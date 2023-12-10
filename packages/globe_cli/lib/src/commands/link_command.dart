import 'package:mason_logger/mason_logger.dart';

import '../command.dart';
import '../utils/prompts.dart';

/// `globe logout`
///
/// Links the local project to a Globe project.
class LinkCommand extends BaseGlobeCommand {
  @override
  String get description => 'Link this local project to a Globe project.';

  @override
  String get name => 'link';

  @override
  Future<int> run() async {
    requireAuth();

    await linkProject(logger: logger, api: api);
    return ExitCode.success.code;
  }
}
