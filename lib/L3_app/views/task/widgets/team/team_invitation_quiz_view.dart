// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/page.dart';
import '../../../../extra/router.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../main/widgets/left_menu.dart';
import '../../../quiz/abstract_quiz_controller.dart';
import '../../../quiz/quiz_header.dart';
import '../../../quiz/quiz_next_button.dart';
import '../../controllers/task_controller.dart';
import 'team.dart';

class TIQuizArgs {
  TIQuizArgs(this._taskController, this._qController);
  final TaskController _taskController;
  final AbstractQuizController _qController;
}

class TeamInvitationQuizRouter extends MTRouter {
  @override
  String get path => '/projects/create/team';

  TIQuizArgs? get _args => rs!.arguments as TIQuizArgs?;

  @override
  Widget? get page => _args != null ? TeamInvitationQuizView(_args!) : null;

  // TODO: если будет инфа об айдишнике проекта, то можем показывать сам проект
  @override
  RouteSettings? get settings => _args != null ? rs : const RouteSettings(name: '/projects');

  @override
  String get title => '${(rs!.arguments as TIQuizArgs?)?._taskController.task?.viewTitle ?? ''} | ${loc.team_title}';
}

class TeamInvitationQuizView extends StatelessWidget {
  const TeamInvitationQuizView(this._args, {super.key});
  final TIQuizArgs _args;

  TaskController get _taskController => _args._taskController;
  Task? get _task => _taskController.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _task != null
          ? MTPage(
              appBar: QuizHeader(_args._qController),
              leftBar: isBigScreen(context) ? const LeftMenu() : null,
              body: SafeArea(
                top: false,
                bottom: false,
                child: MTAdaptive(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Team(_taskController, standalone: false),
                      const SizedBox(height: P3),
                      QuizNextButton(_args._qController, margin: EdgeInsets.zero),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
