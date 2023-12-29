// Copyright (c) 2023. Alexandr Moroz

import '../../../../components/colors_base.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_controller.dart';
import 'team.dart';

Future showTeamDialog(TaskController controller) async => await showMTDialog<void>(
      MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          middle: controller.task!.subPageTitle(loc.team_title),
        ),
        body: Team(controller),
      ),
    );
