// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/presenters/task_filter_presenter.dart';
import 'package:avanplan/L3_app/views/task/task_add_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_button.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../task_view_controller.dart';
import '../../widgets/task_add_button.dart';
import '../../widgets/tasks_list_view.dart';
import '../../widgets/transfer/local_import_dialog.dart';
import 'tasks_board_view.dart';
import 'tasks_pane_controller.dart';

class TasksPane extends StatelessWidget {
  const TasksPane(this.taskController, this.paneController);
  final TaskViewController taskController;
  final TasksPaneController paneController;
  Task get task => taskController.task;

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

  Widget? get bottomBar => (task.canCreate || task.hasOpenedSubtasks)
      ? Row(children: [
          if (task.hasOpenedSubtasks)
            MTButton.secondary(
              color: borderColor,
              middle: Row(children: [
                _switchPart(ListIcon(active: !paneController.showBoard), !paneController.showBoard),
                _switchPart(BoardIcon(active: paneController.showBoard), paneController.showBoard),
              ]),
              onTap: paneController.toggleMode,
              margin: const EdgeInsets.only(left: P),
              constrained: false,
            ),
          const Spacer(),
          if (task.canLocalImport)
            MTButton.secondary(
              middle: const LocalImportIcon(),
              constrained: false,
              onTap: () => localImportDialog(taskController),
            ),
          if (task.canCreate) ...[
            const SizedBox(width: P),
            TaskAddButton(TaskAddController(task.ws, task), compact: true),
          ]
        ])
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => paneController.showBoard ? TasksBoardView(paneController) : TasksListView(task.subtaskGroups, task.type!),
    );
  }
}
