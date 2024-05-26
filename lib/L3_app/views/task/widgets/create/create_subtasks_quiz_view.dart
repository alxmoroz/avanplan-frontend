// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_tree.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/abstract_task_quiz_route.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import '../tasks/task_checklist_item.dart';

class CreateSubtasksQuizRoute extends AbstractTaskQuizRoute {
  static const staticBaseName = 'subtasks';

  CreateSubtasksQuizRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _CreateSubtasksQuizView(
            state.extra as AbstractTaskQuizController,
            parent?.controller as TaskController,
          ),
        );
}

class _CreateSubtasksQuizView extends StatelessWidget {
  const _CreateSubtasksQuizView(this._qController, this._taskController);
  final AbstractTaskQuizController _qController;
  final TaskController _taskController;

  Task get _task => _taskController.task;
  SubtasksController get _subtasksController => _taskController.subtasksController;

  Widget get _addButton => MTField(
        const MTFieldData(-1),
        leading: const PlusIcon(circled: true, size: P6),
        value: BaseText.f2(addSubtaskActionTitle(_task)),
        onTap: _subtasksController.add,
      );

  Widget _itemBuilder(BuildContext context, int index) {
    return index == _subtasksController.tasksControllers.length
        ? _addButton
        : TaskChecklistItem(
            _subtasksController.tasksControllers.elementAt(index),
            bottomDivider: true,
            onSubmit: _subtasksController.add,
            onDelete: () => _subtasksController.delete(index),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: QuizHeader(_qController),
        leftBar: isBigScreen(context) ? LeftMenu(leftMenuController) : null,
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTAdaptive(
            child: MTShadowed(
              topShadow: _task.hasSubtasks,
              child: Align(
                alignment: _task.hasSubtasks ? Alignment.topCenter : Alignment.center,
                child: ListView(
                  shrinkWrap: !_task.hasSubtasks,
                  children: [
                    _task.hasSubtasks
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: _itemBuilder,
                            itemCount: _task.subtasks.length + 1,
                          )
                        : ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              MTImage(ImageName.empty_tasks.name),
                              H2(loc.task_list_empty_hint, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
                              const SizedBox(height: P3),
                              _addButton,
                            ],
                          ),
                    QuizNextButton(_qController),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
