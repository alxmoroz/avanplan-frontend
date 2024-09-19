// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/page.dart';
import '../../../quiz/abstract_task_quiz_route.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/create_project_quiz_controller.dart';
import '../../controllers/task_controller.dart';
import 'project_team.dart';

class ProjectTeamQuizRoute extends AbstractTaskQuizRoute {
  static const staticBaseName = 'team';

  ProjectTeamQuizRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, state) => _TeamQuizView(state.extra as CreateProjectQuizController),
        );
}

class _TeamQuizView extends StatefulWidget {
  const _TeamQuizView(this._qController);
  final CreateProjectQuizController _qController;

  @override
  State<StatefulWidget> createState() => _TeamQuizViewState();
}

class _TeamQuizViewState extends State<_TeamQuizView> {
  late final ScrollController scrollController;

  CreateProjectQuizController get _qController => widget._qController;
  TaskController get _taskController => _qController.taskController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qHeader = QuizHeader(_qController);
    return MTPage(
      topBar: qHeader,
      body: MTAdaptive(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: P3),
            ProjectTeam(_taskController, standalone: false),
            const SizedBox(height: P3),
            QuizNextButton(_qController, margin: EdgeInsets.zero),
          ],
        ),
      ),
      scrollController: scrollController,
      scrollOffsetTop: qHeader.preferredSize.height,
    );
  }
}
