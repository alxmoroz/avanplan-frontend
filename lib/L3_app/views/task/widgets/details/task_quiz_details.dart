// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/task_controller.dart';
import 'task_description_field.dart';

class TaskQuizDetails extends StatelessWidget {
  const TaskQuizDetails(this._qController, this._taskController, {super.key});
  final AbstractTaskQuizController _qController;
  final TaskController _taskController;

  Task get _task => _taskController.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          const SizedBox(height: P),
          TaskDescriptionField(_taskController),
          QuizNextButton(_qController, disabled: _task.loading),
        ],
      ),
    );
  }
}
