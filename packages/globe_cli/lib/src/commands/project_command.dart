import '../command.dart';
import 'project/project_pause_command.dart';
import 'project/project_resume_command.dart';

class ProjectCommand extends BaseGlobeCommand {
  TokenCommand() {
    addSubcommand(ProjectPauseCommand());
    addSubcommand(ProjectResumeCommand());
  }

  @override
  String get description => 'Manage your globe project.';

  @override
  String get name => 'project';
}
