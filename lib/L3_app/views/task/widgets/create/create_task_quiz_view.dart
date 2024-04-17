// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/error_sheet.dart';
import '../../../../components/page.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../controllers/task_controller.dart';
import '../../task_view.dart';
import '../details/task_quiz_details.dart';
import '../header/task_header.dart';

class CreateTaskQuizArgs {
  CreateTaskQuizArgs(this._controller, this._qController);
  final TaskController _controller;
  final AbstractQuizController _qController;
}

class _CreateQuizRouter extends MTRouter {
  CreateTaskQuizArgs? get _args => rs!.arguments as CreateTaskQuizArgs?;

  @override
  Widget? get page => _args != null ? CreateTaskQuizView(_args!) : null;

  // TODO: можем показывать сам проект
  @override
  RouteSettings? get settings => _args != null ? rs : const RouteSettings(name: '/');

  @override
  String get title => (rs!.arguments as CreateTaskQuizArgs?)?._controller.task?.viewTitle ?? '';
}

class CreateProjectQuizRouter extends _CreateQuizRouter {
  @override
  String path({Object? args}) => '/create_project';
}

class CreateGoalQuizRouter extends _CreateQuizRouter {
  @override
  String path({Object? args}) => '/create_goal';
}

class CreateTaskQuizView extends TaskView {
  CreateTaskQuizView(this._args, {super.key}) : super(_args._controller);
  final CreateTaskQuizArgs _args;

  @override
  State<CreateTaskQuizView> createState() => _CreateTaskQuizViewState();
}

class _CreateTaskQuizViewState extends TaskViewState<CreateTaskQuizView> {
  AbstractQuizController get qController => widget._args._qController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => task != null
          ? Stack(
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
                        MTAdaptive(child: TaskQuizDetails(controller, qController)),
                      ],
                    ),
                  ),
                ),
                if (task!.error != null)
                  MTErrorSheet(task!.error!, onClose: () {
                    task!.error = null;
                    tasksMainController.refreshTasksUI();
                  }),
              ],
            )
          : Container(),
    );
  }
}
