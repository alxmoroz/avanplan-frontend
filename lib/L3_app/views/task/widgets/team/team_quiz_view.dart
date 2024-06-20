// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/page.dart';
import '../../../main/main_view.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_task_quiz_route.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/create_project_quiz_controller.dart';
import '../../controllers/task_controller.dart';
import 'team.dart';

class TeamQuizRoute extends AbstractTaskQuizRoute {
  static const staticBaseName = 'team';

  TeamQuizRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _TeamQuizView(state.extra as CreateProjectQuizController),
        );
}

class _TeamQuizView extends StatelessWidget {
  const _TeamQuizView(this._qController);
  final CreateProjectQuizController _qController;
  TaskController get _taskController => _qController.taskController;

  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: QuizHeader(_qController),
      leftBar: isBigScreen(context) ? LeftMenu(leftMenuController) : null,
      body: SafeArea(
        top: false,
        bottom: false,
        child: MTAdaptive(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: P3),
              Team(_taskController, standalone: false),
              const SizedBox(height: P3),
              QuizNextButton(_qController, margin: EdgeInsets.zero),
            ],
          ),
        ),
      ),
    );
  }
}
