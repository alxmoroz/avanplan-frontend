// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/quiz_next_button.dart';
import 'description_field.dart';

class TaskQuizDetails extends StatelessWidget {
  const TaskQuizDetails(this.qController, {super.key});
  final AbstractTaskQuizController qController;

  Task get _task => qController.taskController.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: P3),
          TaskDescriptionField(qController.taskController),
          QuizNextButton(qController, disabled: _task.loading),
        ],
      ),
    );
  }
}
