// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/page.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../task_view.dart';
import '../details/task_quiz_details.dart';
import '../header/task_header.dart';

class CreateTaskQuizView extends TaskView {
  const CreateTaskQuizView(super.controller, this.qController, {super.key});
  final AbstractTaskQuizController qController;

  @override
  State<CreateTaskQuizView> createState() => _CreateTaskQuizViewState();
}

class _CreateTaskQuizViewState extends TaskViewState<CreateTaskQuizView> {
  AbstractTaskQuizController get qController => widget.qController;

  @override
  Widget build(BuildContext context) {
    final qHeader = QuizHeader(qController);
    return MTPage(
      key: widget.key,
      topBar: qHeader,
      body: ListView(
        children: [
          if (controller.task.parentId == null) const SizedBox(height: P),
          TaskHeader(controller),
          MTAdaptive(
            padding: const EdgeInsets.symmetric(horizontal: P3),
            child: TaskQuizDetails(qController, controller),
          ),
        ],
      ),
      scrollController: scrollController,
      scrollOffsetTop: qHeader.preferredSize.height,
    );
  }
}
