// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L1_domain/entities_extensions/task_tree.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
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

  Task get task => taskController.task;

  @observable
  bool onboarding = false;
}
