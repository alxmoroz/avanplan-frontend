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
import '../../controllers/onboarding_controller.dart';
import '../../controllers/task_controller.dart';
import '../onboarding/header.dart';
import '../onboarding/next_button.dart';
import 'invitation_button.dart';
import 'team_pane.dart';

class TIOnboardingArgs {
  TIOnboardingArgs(this._taskController, this._onbController);
  final TaskController _taskController;
  final OnboardingController _onbController;
}

class TeamInvitationOnboardingView extends StatelessWidget {
  const TeamInvitationOnboardingView(this._args);
  final TIOnboardingArgs _args;

  static String get routeName => '/team_invitation';
  static String title(TIOnboardingArgs _args) => '${_args._taskController.task.viewTitle} - ${loc.team_title}';

  TaskController get _taskController => _args._taskController;
  Task get _task => _taskController.task;

  @override
  Widget build(BuildContext context) {
    final teamPane = TeamPane(_taskController);
    return Observer(
      builder: (_) => MTPage(
        appBar: onboardingHeader(context, _args._onbController),
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
          OnboardingNextButton(_args._onbController, margin: EdgeInsets.zero),
        ]),
      ),
    );
  }
}
