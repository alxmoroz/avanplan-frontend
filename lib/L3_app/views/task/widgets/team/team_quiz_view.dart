// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/page.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_task_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/task_controller.dart';
import '../../task_route.dart';
import 'team.dart';

class TeamQuizRoute extends BaseTaskRoute {
  static const staticBaseName = 'team';

  TeamQuizRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  String get path => staticBaseName;

  @override
  GoRouterRedirect? get redirect => (_, state) {
        if (state.extra == null) {
          return router.namedLocation(parent!.name, pathParameters: state.pathParameters);
        }
        return null;
      };

  @override
  String? title(GoRouterState state) => '${super.title(state)} | ${loc.team_title}';

  @override
  GoRouterWidgetBuilder? get builder => (_, state) => _TeamQuizView(state.extra as TaskController);
}

class _TeamQuizView extends StatelessWidget {
  const _TeamQuizView(this._controller);
  final TaskController _controller;

  AbstractTaskQuizController get _qController => _controller.quizController!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: QuizHeader(_qController),
        leftBar: isBigScreen(context) ? LeftMenu(leftMenuController) : null,
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTAdaptive(
            child: ListView(
              shrinkWrap: true,
              children: [
                Team(_controller, standalone: false),
                const SizedBox(height: P3),
                QuizNextButton(_qController, margin: EdgeInsets.zero),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
