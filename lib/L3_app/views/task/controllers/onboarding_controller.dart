// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../task_view.dart';
import 'task_controller.dart';

part 'onboarding_controller.g.dart';

class OnboardingController extends _OnboardingControllerBase with _$OnboardingController {
  OnboardingController(TaskController _taskController) {
    taskController = _taskController;
    onboarding = taskController.task.isNew && !taskController.task.isTask;
  }
}

abstract class _OnboardingControllerBase with Store {
  late final TaskController taskController;

  @observable
  bool onboarding = false;

  @action
  void skip(BuildContext context) {
    Navigator.of(context).popUntil((r) => r.navigator?.canPop() == true && r.settings.name == TaskView.routeName);
    onboarding = false;
  }
}
