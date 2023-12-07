// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../quiz/header.dart';
import '../../../quiz/next_button.dart';
import '../../../quiz/quiz_controller.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import '../../task_view.dart';
import '../../widgets/create/create_task_button.dart';
import '../tasks/task_checklist_item.dart';

class CreateMultiTaskQuizArgs {
  CreateMultiTaskQuizArgs(this._controller, this._qController);
  final TaskController _controller;
  final QuizController _qController;
}

class CreateMultiTaskQuizRouter extends MTRouter {
  @override
  String get path => '/projects/create/tasks';

  CreateMultiTaskQuizArgs? get _args => rs!.arguments as CreateMultiTaskQuizArgs?;

  @override
  Widget? get page => _args != null ? CreateMultiTaskQuizView(_args!) : null;

  // TODO: если будет инфа об айдишнике проекта, то можем показывать сам проект
  @override
  RouteSettings? get settings => _args != null ? rs : const RouteSettings(name: '/projects');

  @override
  String get title => (rs!.arguments as CreateMultiTaskQuizArgs?)?._controller.task?.viewTitle ?? '';
}

class CreateMultiTaskQuizView extends TaskView {
  CreateMultiTaskQuizView(this._args) : super(_args._controller);
  final CreateMultiTaskQuizArgs _args;

  @override
  State<CreateMultiTaskQuizView> createState() => _CreateMultiTaskQuizViewState();
}

class _CreateMultiTaskQuizViewState extends State<CreateMultiTaskQuizView> {
  QuizController get qController => widget._args._qController;
  TaskController get parentTaskController => widget._args._controller;
  SubtasksController get controller => parentTaskController.subtasksController;

  Widget get addButton => CreateTaskButton(
        parentTaskController,
        type: ButtonType.secondary,
        margin: const EdgeInsets.only(top: P3),
        uf: false,
        onTap: controller.addTask,
      );

  Widget itemBuilder(BuildContext context, int index) {
    if (index == controller.taskControllers.length) {
      return addButton;
    } else {
      return TaskChecklistItem(controller, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTPage(
            appBar: QuizHeader(qController),
            body: SafeArea(
              top: false,
              bottom: false,
              child: MTAdaptive(
                child: controller.taskControllers.isNotEmpty
                    ? MTShadowed(
                        bottomShadow: true,
                        child: ListView.builder(
                          itemBuilder: itemBuilder,
                          itemCount: controller.taskControllers.length + 1,
                        ),
                      )
                    : Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            MTImage(ImageName.empty_tasks.name),
                            H2(loc.task_list_empty_hint, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
                            addButton,
                          ],
                        ),
                      ),
              ),
            ),
            bottomBar: MTAppBar(
              isBottom: true,
              middle: QuizNextButton(qController, margin: EdgeInsets.zero),
            ),
          ),
        ],
      ),
    );
  }
}
