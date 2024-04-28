// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/error_sheet.dart';
import '../../../../components/page.dart';
import '../../../../extra/services.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../task_view.dart';
import '../details/task_quiz_details.dart';
import '../header/task_header.dart';

class CreateTaskQuizView extends TaskView {
  const CreateTaskQuizView(super.taskIn, {super.key}) : super(isNew: true);

  @override
  State<CreateTaskQuizView> createState() => _CreateTaskQuizViewState();
}

class _CreateTaskQuizViewState extends TaskViewState<CreateTaskQuizView> {
  AbstractTaskQuizController get qController => controller.quizController!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTPage(
            appBar: QuizHeader(qController),
            leftBar: isBigScreen(context) ? LeftMenu(leftMenuController) : null,
            body: SafeArea(
              top: false,
              bottom: false,
              child: ListView(
                children: [
                  const SizedBox(height: P),
                  TaskHeader(controller),
                  MTAdaptive(child: TaskQuizDetails(qController)),
                ],
              ),
            ),
          ),
          if (task != null && task!.error != null)
            MTErrorSheet(task!.error!, onClose: () {
              task!.error = null;
              tasksMainController.refreshTasksUI();
            }),
        ],
      ),
    );
  }
}
