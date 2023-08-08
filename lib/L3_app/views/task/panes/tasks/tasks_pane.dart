// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_button.dart';
import '../../../../presenters/task_filter_presenter.dart';
import '../../../../usecases/task_available_actions.dart';
import '../../controllers/task_controller.dart';
import '../../widgets/task_add_button.dart';
import '../../widgets/tasks_list_view.dart';
import '../../widgets/transfer/local_import_dialog.dart';
import 'tasks_board_view.dart';
import 'tasks_pane_controller.dart';

class TasksPane extends StatelessWidget {
  const TasksPane(this.controller);
  final TasksPaneController controller;

  Task get _task => controller.task;
  TaskController get _taskController => controller.taskController;

  Widget _switchPart(Widget icon, bool active) => Container(
        decoration: active
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: lightBackgroundColor.resolve(rootKey.currentContext!),
              )
            : null,
        width: P2 * 2,
        height: MIN_BTN_HEIGHT,
        child: icon,
      );

  Widget? get bottomBar => (_task.canCreate || _task.hasOpenedSubtasks)
      ? Row(children: [
          if (_task.hasOpenedSubtasks)
            MTButton.secondary(
              color: borderColor,
              middle: Row(children: [
                _switchPart(ListIcon(active: !controller.showBoard), !controller.showBoard),
                _switchPart(BoardIcon(active: controller.showBoard), controller.showBoard),
              ]),
              onTap: controller.toggleMode,
              margin: const EdgeInsets.only(left: P),
              constrained: false,
            ),
          const Spacer(),
          if (_task.canLocalImport)
            MTButton.secondary(
              middle: const LocalImportIcon(),
              constrained: false,
              onTap: () => localImportDialog(_taskController),
            ),
          if (_task.canCreate) ...[
            const SizedBox(width: P),
            TaskAddButton(_taskController.addController, compact: true),
          ]
        ])
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.showBoard ? TasksBoardView(_taskController.statusController) : TasksListView(_task.subtaskGroups, _task.type!),
    );
  }
}
