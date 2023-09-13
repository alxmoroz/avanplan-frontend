// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/error_sheet.dart';
import '../../components/page.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import 'controllers/onboarding_controller.dart';
import 'controllers/task_controller.dart';
import 'task_view.dart';
import 'widgets/details/details_pane.dart';
import 'widgets/header/task_header.dart';
import 'widgets/onboarding/header.dart';

class TaskOnboardingArgs {
  TaskOnboardingArgs(this._controller, this._onbController);
  final TaskController _controller;
  final OnboardingController _onbController;
}

class TaskOnboardingView extends TaskView {
  TaskOnboardingView(this._args) : super(_args._controller);
  final TaskOnboardingArgs _args;

  static String get routeNameGoal => '/goal';
  static String get routeNameProject => '/project_onboarding';
  static String title(TaskOnboardingArgs _args) => '${_args._controller.task.viewTitle}';

  @override
  State<TaskOnboardingView> createState() => GoalOnboardingViewState();
}

class GoalOnboardingViewState extends TaskViewState<TaskOnboardingView> {
  OnboardingController get onbController => widget._args._onbController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTPage(
            appBar: onboardingHeader(context, onbController),
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TaskHeader(controller),
                  Expanded(child: DetailsPane(controller, onbController: onbController)),
                ],
              ),
            ),
          ),
          if (task.error != null)
            MTErrorSheet(task.error!, onClose: () {
              task.error = null;
              mainController.refresh();
            }),
        ],
      ),
    );
  }
}
