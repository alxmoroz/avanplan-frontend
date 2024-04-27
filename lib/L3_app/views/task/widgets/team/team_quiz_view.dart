// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/page.dart';
import '../../../../extra/services.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/task_controller.dart';
import '../../task_route.dart';
import 'team.dart';

class _TeamQuizRoute extends TaskRoute {
  _TeamQuizRoute() : super(path: 'team', name: 'team');

  @override
  GoRouterRedirect? get redirect => (context, state) {
        if (state.extra == null) {
          return context.namedLocation(TaskRoute.rName(task(state)!), pathParameters: state.pathParameters);
        }
        return null;
      };

  @override
  String? title(GoRouterState state) => '${super.title(state)} | ${loc.team_title}';

  @override
  GoRouterWidgetBuilder? get builder => (_, state) => _TeamQuizView(qController(TaskController(task(state)!, isNew: true), state)!);
}

final teamQuizRoute = _TeamQuizRoute();

class _TeamQuizView extends StatelessWidget {
  const _TeamQuizView(this._qController);
  final AbstractTaskQuizController _qController;

  TaskController get _taskController => _qController.taskController;
  Task? get _task => _taskController.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _task != null
          ? MTPage(
              appBar: QuizHeader(_qController),
              leftBar: isBigScreen(context) ? LeftMenu(leftMenuController) : null,
              body: SafeArea(
                top: false,
                bottom: false,
                child: MTAdaptive(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Team(_taskController, standalone: false),
                      const SizedBox(height: P3),
                      QuizNextButton(_qController, margin: EdgeInsets.zero),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
