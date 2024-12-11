import 'dart:async';

import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';

import '../command.dart';
import '../package_info.dart' as package_info;

class UpdateCommand extends BaseGlobeCommand {
  UpdateCommand(this.updater);

  final PubUpdater updater;

  @override
  String get description => 'Updates the CLI to the latest version.';

  @override
  String get name => 'update';

  @override
  FutureOr<int>? run() async {
    final isUpToDate = await updater.isUpToDate(
      packageName: package_info.packageName,
      currentVersion: package_info.version,
    );

    if (isUpToDate) {
      logger.info('CLI is up to date.');
      return ExitCode.success.code;
    }

    logger.progress('Updating Globe CLI');

    final result = await updater.update(
      packageName: package_info.name,
    );

    if (result.exitCode != 0) {
      logger.err('\nFailed to update CLI.');
      return ExitCode.software.code;
    }

    logger.success('\nCLI updated successfully.');

    return ExitCode.success.code;
  }
}
