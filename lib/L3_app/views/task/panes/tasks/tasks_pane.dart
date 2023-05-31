// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_button.dart';
import '../../../../presenters/task_view_presenter.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../project_add_wizard/project_add_wizard.dart';
import '../../task_view_controller.dart';
import '../../widgets/task_add_button.dart';
import 'tasks_board_view.dart';
import 'tasks_list_view.dart';
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

  Widget? get bottomBar => task.isRoot || task.canCreate || task.canShowBoard
      ? Row(children: [
          if (task.canShowBoard)
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
          if (task.isRoot || task.canCreate) ...[
            const Spacer(),
            task.isRoot ? const MTPlusButton(projectAddWizard) : TaskAddButton(taskController, compact: true),
          ]
        ])
      : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => paneController.showBoard ? TasksBoardView(paneController) : TasksListView(paneController),
    );
  }
}
