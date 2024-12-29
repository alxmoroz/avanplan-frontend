// Copyright (c) 2023. Alexandr Moroz

import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import 'project_team.dart';

Future showProjectTeamDialog(TaskController controller) async => await showMTDialog(
      MTDialog(
        topBar: MTTopBar(pageTitle: loc.team_title, parentPageTitle: controller.task.title),
        body: ProjectTeam(controller),
        forceBottomPadding: true,
      ),
    );
