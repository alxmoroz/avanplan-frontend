// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/error_sheet.dart';
import '../../../../components/page.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../quiz/header.dart';
import '../../../quiz/quiz_controller.dart';
import '../../controllers/task_controller.dart';
import '../../task_view.dart';
import '../details/details_pane.dart';
import '../header/task_header.dart';

class CreateTaskQuizArgs {
  CreateTaskQuizArgs(this._controller, this._qController);
  final TaskController _controller;
  final QuizController _qController;
}

class _CreateQuizRouter extends MTRouter {
  CreateTaskQuizArgs? get _args => rs!.arguments as CreateTaskQuizArgs?;

  @override
  Widget? get page => _args != null ? CreateTaskQuizView(_args!) : null;

  // TODO: если будет инфа об айдишнике проекта, то можем показывать сам проект
  @override
  RouteSettings? get settings => _args != null ? rs : const RouteSettings(name: '/projects');

  @override
  String get title => (rs!.arguments as CreateTaskQuizArgs?)?._controller.task.viewTitle ?? '';
}

class CreateProjectQuizViewRouter extends _CreateQuizRouter {
  @override
  String get path => '/projects/create';
}

class CreateGoalQuizViewRouter extends _CreateQuizRouter {
  @override
  String get path => '/projects/create_goal';
}

class CreateTaskQuizView extends TaskView {
  CreateTaskQuizView(this._args) : super(_args._controller);
  final CreateTaskQuizArgs _args;

  @override
  State<CreateTaskQuizView> createState() => CreateTaskQuizViewState();
}

class CreateTaskQuizViewState extends TaskViewState<CreateTaskQuizView> {
  QuizController get qController => widget._args._qController;

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
