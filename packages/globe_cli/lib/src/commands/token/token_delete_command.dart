import 'dart:async';

import '../../command.dart';

class TokenDeleteCommand extends BaseGlobeCommand {
  @override
  String get description => 'Delete token associated with project.';

  @override
  String get name => 'delete';

  @override
  FutureOr<int> run() async {
    requireAuth();

    return 0;
  }
}
