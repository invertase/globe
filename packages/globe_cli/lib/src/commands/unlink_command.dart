import 'package:mason_logger/mason_logger.dart';

import '../command.dart';

/// `dart_deploy logout`
///
/// Unlink this local project from a Globe project.
class UnlinkCommand extends BaseGlobeCommand {
  @override
  String get description => 'Unlink this project from a Globe project.';

  @override
  String get name => 'unlink';

  @override
  Future<int> run() async {
    requireAuth();

    if (scope.hasScope()) {
      scope.unlink();
    } else if (scope.workspace.isNotEmpty) {
      final selected = await scope.selectOrLinkNewScope(canLinkNew: false);
      scope.unlinkScope(selected);
    }

    logger.success(
      'Project unlinked successfully. To link this project again, run ${cyan.wrap('globe link')}.',
    );
    return ExitCode.success.code;
  }
}
