// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/page.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_actions.dart';
import '../../../quiz/header.dart';
import '../../../quiz/next_button.dart';
import '../../../quiz/quiz_controller.dart';
import '../../controllers/task_controller.dart';
import 'invitation_button.dart';
import 'team_pane.dart';

class TIQuizArgs {
  TIQuizArgs(this._taskController, this._qController);
  final TaskController _taskController;
  final QuizController _qController;
}

class TeamInvitationQuizView extends StatelessWidget {
  const TeamInvitationQuizView(this._args);
  final TIQuizArgs _args;

  static String get routeName => '/create_project_quiz/team_invitation';
  static String title(TIQuizArgs _args) => '${_args._taskController.task.viewTitle} - ${loc.team_title}';

  TaskController get _taskController => _args._taskController;
  Task get _task => _taskController.task;

  @override
  Widget build(BuildContext context) {
    final teamPane = TeamPane(_taskController);
    return Observer(
      builder: (_) => MTPage(
        appBar: quizHeader(context, _args._qController),
        body: SafeArea(
          top: false,
          bottom: false,
          child: teamPane,
        ),
        bottomBar: Column(mainAxisSize: MainAxisSize.min, children: [
          if (_task.canInviteMembers) ...[
            InvitationButton(_task, type: ButtonType.secondary),
            const SizedBox(height: P3),
          ],
          QuizNextButton(_args._qController, margin: EdgeInsets.zero),
        ]),
      ),
    );
  }
}
