import 'dart:async';

import '../../command.dart';

class TokenCreateCommand extends BaseGlobeCommand {
  TokenCreateCommand() {
    argParser
      ..addOption(
        'name',
        // abbr: 'n',
        help: 'Specify name to identity token.',
      )
      ..addOption(
        'expiry',
        // abbr: 'x',
        help: 'Specify lifespan of token.',
      )
      ..addOption(
        'project',
        // abbr: 'p',
        help: 'Specify projects(s) to associate token with.',
      );
  }

  @override
  String get description => 'Create auth tokens for your projects.';

  @override
  String get name => 'create';

  @override
  FutureOr<int> run() async {
    requireAuth();

    return 0;
  }
}
