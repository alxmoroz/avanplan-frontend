// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../main.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/toolbar.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../widgets/local_transfer/local_import_dialog.dart';
import '../create/create_task_button.dart';
import '../empty_state/no_tasks.dart';
import 'task_checklist.dart';
import 'tasks_board.dart';
import 'tasks_list_view.dart';

class TasksPane extends StatelessWidget {
  const TasksPane(this.controller);
  final TaskController controller;

  Task get _task => controller.task!;

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

  Widget? get bottomBar => _task.canShowBoard || _task.canLocalImport || (_task.canCreate && !_task.isCheckList)
      ? MTAdaptive(
          force: true,
          child: MTAppBar(
            isBottom: true,
            leading: _task.canShowBoard
                ? MTButton.secondary(
                    color: b1Color,
                    middle: Row(children: [
                      _switchPart(ListIcon(active: !controller.showBoard), !controller.showBoard),
                      _switchPart(BoardIcon(active: controller.showBoard), controller.showBoard),
                    ]),
                    onTap: controller.toggleMode,
                    margin: const EdgeInsets.only(left: P3),
                    constrained: false,
                  )
                : null,
            trailing: Row(
              children: [
                if (_task.canLocalImport)
                  MTButton.secondary(
                    middle: const LocalImportIcon(),
                    constrained: false,
                    onTap: () => localImportDialog(controller),
                  ),
                if (_task.canCreate) ...[
                  const SizedBox(width: P2),
                  CreateTaskButton(controller, compact: true),
                ] else
                  const SizedBox(width: P3),
              ],
            ),
          ),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _task.subtasks.isEmpty && _task.totalVolume == 0
          ? NoTasks(controller)
          : _task.canShowBoard && controller.showBoard
              ? TasksBoard(
                  controller.statusController,
                  extra: controller.subtasksController.loadClosedButton(board: true),
                )
              : _task.isCheckList
                  ? TaskChecklist(controller)
                  : TasksListView(
                      _task.subtaskGroups,
                      extra: controller.subtasksController.loadClosedButton(),
                    ),
    );
  }
}
