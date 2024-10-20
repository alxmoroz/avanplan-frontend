// Copyright (c) 2023. Alexandr Moroz

import '../../../../components/colors_base.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import 'project_team.dart';

Future showProjectTeamDialog(TaskController controller) async => await showMTDialog(
      MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          pageTitle: loc.team_title,
          parentPageTitle: controller.task.title,
        ),
        body: ProjectTeam(controller),
      ),
    );
