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
import '../../../../extra/services.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import '../../task_route.dart';
import '../../task_view.dart';
import '../../widgets/create/create_task_button.dart';
import '../tasks/task_checklist_item.dart';

class _CreateSubtasksQuizRoute extends TaskRoute {
  _CreateSubtasksQuizRoute(String prefix) : super(path: 'subtasks', name: '$prefix-subtasks');

  @override
  GoRouterRedirect? get redirect => (context, state) {
        if (state.extra == null) {
          return context.namedLocation(TaskRoute.rName(task(state)!), pathParameters: state.pathParameters);
        }
        return null;
      };

  @override
  GoRouterWidgetBuilder? get builder => (_, state) => _CreateSubtasksQuizView(qController(TaskController(task(state)!, isNew: true), state)!);
}

final createSubtasksProjectQuizRoute = _CreateSubtasksQuizRoute('project');
final createSubtasksGoalQuizRoute = _CreateSubtasksQuizRoute('goal');
final createSubtasksQuizRoutes = {
  'project': createSubtasksProjectQuizRoute,
  'goal': createSubtasksGoalQuizRoute,
};

class _CreateSubtasksQuizView extends TaskView {
  _CreateSubtasksQuizView(this._qController) : super(_qController.taskController);
  final AbstractTaskQuizController _qController;

  @override
  State<_CreateSubtasksQuizView> createState() => _CreateSubtasksQuizViewState();
}

class _CreateSubtasksQuizViewState extends TaskViewState<_CreateSubtasksQuizView> {
  AbstractTaskQuizController get qController => widget._qController;
  SubtasksController get subtasksController => controller.subtasksController;

  Widget get addButton => CreateTaskButton(
        controller,
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
