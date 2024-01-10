// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../quiz/abstract_quiz_controller.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/task_controller.dart';
import 'description_field.dart';

class TaskQuizDetails extends StatelessWidget {
  const TaskQuizDetails(this._controller, this.qController, {super.key});
  final TaskController _controller;
  final AbstractQuizController qController;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: P3),
          TaskDescriptionField(_controller),
          QuizNextButton(qController, disabled: _task.loading),
        ],
      ),
    );
  }
}
