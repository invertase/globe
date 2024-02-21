import '../command.dart';
import 'token/token_create_command.dart';
import 'token/token_delete_command.dart';
import 'token/token_list_command.dart';

class TokenCommand extends BaseGlobeCommand {
  TokenCommand() {
    addSubcommand(TokenCreateCommand());
    addSubcommand(TokenDeleteCommand());
    addSubcommand(TokenListCommand());
  }
  @override
  String get description => 'Manage globe auth tokens.';

  @override
  String get name => 'token';
}
