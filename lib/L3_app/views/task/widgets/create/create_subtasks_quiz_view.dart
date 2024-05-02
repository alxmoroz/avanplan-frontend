// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import '../../task_route.dart';
import '../../widgets/create/create_task_button.dart';
import '../tasks/task_checklist_item.dart';

class CreateSubtasksQuizRoute extends BaseTaskRoute {
  static const staticBaseName = 'subtasks';

  CreateSubtasksQuizRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  String get path => staticBaseName;

  @override
  GoRouterRedirect? get redirect => (_, state) => state.extra is TaskController
      ? null
      : router.namedLocation(
          parent!.name,
          pathParameters: state.pathParameters,
        );

  @override
  GoRouterWidgetBuilder? get builder => (_, state) => _CreateSubtasksQuizView(state.extra as TaskController);
}

class _CreateSubtasksQuizView extends StatelessWidget {
  const _CreateSubtasksQuizView(this._controller);
  final TaskController _controller;

  AbstractQuizController get qController => _controller.quizController!;
  SubtasksController get subtasksController => _controller.subtasksController;

  Widget get addButton => CreateTaskButton(
        _controller,
        type: ButtonType.secondary,
        margin: const EdgeInsets.only(top: P3),
        onTap: subtasksController.addTask,
      );

  Widget itemBuilder(BuildContext context, int index) {
    if (index == subtasksController.taskControllers.length) {
      return addButton;
    } else {
      return TaskChecklistItem(subtasksController, index);
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
            leftBar: isBigScreen(context) ? LeftMenu(leftMenuController) : null,
            body: SafeArea(
              top: false,
              bottom: false,
              child: MTAdaptive(
                child: subtasksController.taskControllers.isNotEmpty
                    ? MTShadowed(
                        bottomShadow: true,
                        child: ListView.builder(
                          itemBuilder: itemBuilder,
                          itemCount: subtasksController.taskControllers.length + 1,
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
              color: b2Color,
              padding: const EdgeInsets.only(top: P2),
              middle: QuizNextButton(qController, margin: EdgeInsets.zero),
            ),
          ),
        ],
      ),
    );
  }
}
