import '../command.dart';
import 'runtime/runtime_install_command.dart';

class RuntimeCommand extends BaseGlobeCommand {
  RuntimeCommand() {
    addSubcommand(RuntimeInstallCommand());
  }

  @override
  String get description => 'Manage globe runtime.';

  @override
  String get name => 'runtime';
}
