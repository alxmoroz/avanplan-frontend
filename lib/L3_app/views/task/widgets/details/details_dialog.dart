// Copyright (c) 2023. Alexandr Moroz

import '../../../../components/colors_base.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_controller.dart';
import 'task_details.dart';

Future showDetailsDialog(TaskController controller) async => await showMTDialog<void>(
      MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          middle: controller.task!.subPageTitle(loc.details),
          bgColor: b2Color,
        ),
        body: TaskDetails(controller, standalone: true),
      ),
    );
