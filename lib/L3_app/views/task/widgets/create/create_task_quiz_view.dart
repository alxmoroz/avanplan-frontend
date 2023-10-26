// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/error_sheet.dart';
import '../../../../components/page.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../quiz/header.dart';
import '../../controllers/create_project_quiz_controller.dart';
import '../../controllers/task_controller.dart';
import '../../task_view.dart';
import '../details/details_pane.dart';
import '../header/task_header.dart';

class CreateTaskQuizArgs {
  CreateTaskQuizArgs(this._controller, this._qController);
  final TaskController _controller;
  final CreateProjectQuizController _qController;
}

class CreateTaskQuizView extends TaskView {
  CreateTaskQuizView(this._args) : super(_args._controller);
  final CreateTaskQuizArgs _args;

  static String get routeNameGoal => '/create_goal_quiz';
  static String get routeNameProject => '/create_project_quiz';
  static String title(CreateTaskQuizArgs _args) => '${_args._controller.task.viewTitle}';

  @override
  State<CreateTaskQuizView> createState() => CreateTaskQuizViewState();
}

class CreateTaskQuizViewState extends TaskViewState<CreateTaskQuizView> {
  CreateProjectQuizController get qController => widget._args._qController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTPage(
            appBar: quizHeader(context, qController),
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TaskHeader(controller),
                  Expanded(child: DetailsPane(controller, qController: qController)),
                ],
              ),
            ),
          ),
          if (task.error != null)
            MTErrorSheet(task.error!, onClose: () {
              task.error = null;
              tasksMainController.refreshTasks();
            }),
        ],
      ),
    );
  }
}
