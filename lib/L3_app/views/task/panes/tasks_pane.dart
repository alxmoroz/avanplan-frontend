// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/usecases/task_feature_sets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../main.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../presenters/task_filter.dart';
import '../../../usecases/task_actions.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_create_button.dart';
import '../widgets/tasks_board.dart';
import '../widgets/tasks_list_view.dart';
import '../widgets/transfer/local_import_dialog.dart';

class TasksPane extends StatelessWidget {
  const TasksPane(this.controller);
  final TaskController controller;

  Task get _task => controller.task;

  Widget _switchPart(Widget icon, bool active) => Container(
        decoration: active
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: b3Color.resolve(rootKey.currentContext!),
              )
            : null,
        width: P8,
        height: MIN_BTN_HEIGHT,
        child: icon,
      );

  Widget? get bottomBar => (_task.canCreate || _task.totalVolume > 0)
      ? Row(children: [
          if (_task.hfsTaskboard && _task.totalVolume > 0 && !_task.isProject)
            MTButton.secondary(
              color: b1Color,
              middle: Row(children: [
                _switchPart(ListIcon(active: !controller.showBoard), !controller.showBoard),
                _switchPart(BoardIcon(active: controller.showBoard), controller.showBoard),
              ]),
              onTap: controller.toggleMode,
              margin: const EdgeInsets.only(left: P3),
              constrained: false,
            ),
          const Spacer(),
          if (_task.canLocalImport)
            MTButton.secondary(
              middle: const LocalImportIcon(),
              constrained: false,
              onTap: () => localImportDialog(controller),
            ),
          if (_task.canCreate) ...[
            const SizedBox(width: P),
            TaskCreateButton(controller.createController, compact: true),
          ]
        ])
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.showBoard
          ? TasksBoard(
              controller.statusController,
              extra: controller.subtasksController.loadClosedButton,
            )
          : TasksListView(
              _task.subtaskGroups,
              extra: controller.subtasksController.loadClosedButton,
            ),
    );
  }
}
