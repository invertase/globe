import 'dart:async';
import 'dart:io';

import 'package:mason_logger/mason_logger.dart';

import '../command.dart';
import '../utils/api.dart';
import '../utils/archiver.dart';
import '../utils/logs.dart';

/// `globe deploy`
///
/// Queues a project to be deployed to the Globe platform. This zips the
/// current project and post it to the Globe API, then give back
/// an URI for checking logs.
class DeployCommand extends BaseGlobeCommand {
  /// {@macro deploy_command}
  DeployCommand() {
    argParser
      ..addFlag(
        'prod',
        help: 'Creates a new deployment, '
            'and if successful promotes it to the latest production deployment.',
      )
      ..addFlag(
        'logs',
        help: 'Shows build logs for the deployment.',
      );

    _validator = declareScopeArguments();
  }

  @override
  String get description => 'Deploy the current project.';

  @override
  String get name => 'deploy';

  DeploymentEnvironment get environment => argResults!['prod'] as bool
      ? DeploymentEnvironment.production
      : DeploymentEnvironment.preview;

  late final ScopeValidator _validator;

  @override
  Future<int> run() async {
    await scope.selectOrLinkNewScope();

    final validated = await _validator();
    if (validated.project.paused) {
      logger
        ..err('No new deployments can be created for this project.')
        ..err(
          '✗ Failed to deploy project: ${cyan.wrap(validated.project.slug)} is paused.',
        )
        ..info(
          'Use ${lightCyan.wrap('globe project resume')} to re-enable deployments.',
        );
      return ExitCode.software.code;
    }

    final deployProgress = logger.progress(
      'Deploying to ${styleBold.wrap('${validated.organization.slug}/${validated.project.slug}')}${environment == DeploymentEnvironment.production ? ' (production)' : ''}',
    );

    // TODO: handle args for deploy command (e.g. --release, --debug, --pub-cache etc.)

    try {
      // Archive the current directory.
      final archive = await zipDir(Directory.current);

      // Deploy the project via the API.
      var deployment = await api.deploy(
        orgId: validated.organization.id,
        projectId: validated.project.id,
        environment: environment,
        archive: archive,
      );

      deployProgress.complete();

      logger.success(
        '${lightGreen.wrap('✓')} Deployment has been queued',
      );

      logger.info(
        '🔍 View deployment: ${metadata.endpoint}/${validated.organization.slug}/${validated.project.slug}/deployments/${deployment.id}',
      );

      var status = logger.progress(deployment.state.message);
      final completer = Completer<Deployment>();

      final shouldShowLogs = argResults!['logs'] as bool;

      if (!shouldShowLogs) {
        Timer.periodic(const Duration(seconds: 2), (timer) async {
          try {
            final update = await api.getDeployment(
              orgId: validated.organization.id,
              projectId: validated.project.id,
              deploymentId: deployment.id,
            );

            if (deployment.state == update.state) return;

            final message = update.message ?? update.state.message;

            switch (update.state) {
              case DeploymentState.working:
                status.complete();
                status = logger.progress(message);
              case DeploymentState.deploying:
                status.complete();
                status = logger.progress(message);
              case DeploymentState.success:
                status.complete();
                logger.info(
                  '${lightGreen.wrap('✓')} Deployment URL: https://${update.url}',
                );
                timer.cancel();
                completer.complete(update);
              case DeploymentState.error:
                status.fail(message);
                timer.cancel();
                completer.complete(update);
              case DeploymentState.cancelled:
                status.complete();
                logger.info('Deployment cancelled');
                timer.cancel();
                completer.complete(update);
              case DeploymentState.invalid:
                status.fail('Invalid Deployment State Received.');
                timer.cancel();
              case DeploymentState.pending:
                status = logger.progress(message);
            }

            deployment = update;
          } catch (_) {}
        });

        try {
          final deployment = await completer.future;

          // Immediately show error if deployment failed
          if (deployment.state == DeploymentState.error) {
            await showBuildLogs(
              api: api,
              logger: logger,
              orgId: validated.organization.id,
              projectId: validated.project.id,
              deploymentId: deployment.id,
              buildId: deployment.buildId!,
            );
          }

          return ExitCode.success.code;
        } catch (_) {
          return ExitCode.software.code;
        }
      }

      Stream<BuildLogEvent>? logs;

      // Check the deployment status every x seconds.
      Timer.periodic(const Duration(milliseconds: 2000), (timer) async {
        final update = await api.getDeployment(
          orgId: validated.organization.id,
          projectId: validated.project.id,
          deploymentId: deployment.id,
        );

        if (update.state == DeploymentState.working ||
            update.state == DeploymentState.deploying) {
          if (logs != null) return;

          status.complete();
          status = logger.progress('Preparing build environment');

          logs = await streamBuildLogs(
            api: api,
            orgId: validated.organization.id,
            projectId: validated.project.id,
            deploymentId: deployment.id,
            buildId: update.buildId!,
          );

          unawaited(
            logs!
                .firstWhere((element) => element is! UnknownBuildLogEvent)
                .then((_) => status.complete()),
          );

          unawaited(
            logs!.firstWhere((element) {
              if (element case BuildLogs(done: final done)) return done;
              return false;
            }).then((_) {
              status = logger.progress('Deploying');
            }),
          );

          unawaited(printLogs(logger, logs!));
        }

        if (update.state == DeploymentState.success) {
          status.complete();
          logger.info(
            '${lightGreen.wrap('✓')} Deployment URL: https://${update.url}',
          );
        }

        final message = update.message ?? update.state.message;

        if (update.state == DeploymentState.error) {
          status.fail('Deployment failed: $message');
        }

        if (update.state == DeploymentState.cancelled) {
          status.complete();
          logger.info('Deployment cancelled');
        }

        if (update.state == DeploymentState.invalid) {
          status.complete();
          status = logger.progress(
            'Invalid Deployment State Received. Waiting for valid state',
          );
        }

        if (update.state == DeploymentState.success ||
            update.state == DeploymentState.cancelled ||
            update.state == DeploymentState.error) {
          timer.cancel();
          completer.complete(update);
        }
      });

      await completer.future;

      return ExitCode.success.code;
    } on ApiException catch (e) {
      deployProgress.fail();
      logger.err('✗ Failed to deploy project: ${e.message}');
      return ExitCode.software.code;
    } catch (e, s) {
      deployProgress.fail();
      logger
        ..err('✗ Failed to deploy project: $e')
        ..err(s.toString());
      return ExitCode.software.code;
    }
  }
}
