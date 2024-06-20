// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/project_module.dart';
import '../../quiz/abstract_quiz_controller.dart';
import '../../quiz/abstract_task_quiz_controller.dart';
import '../widgets/create/create_subtasks_quiz_view.dart';

part 'create_goal_quiz_controller.g.dart';

enum _StepCode { goalSetup, tasks }

class CreateGoalQuizController extends _CreateGoalQuizControllerBase with _$CreateGoalQuizController {
  CreateGoalQuizController(super.taskController);

  @override
  Future afterNext() async {
    if (step.code == _StepCode.tasks.name) {
      await router.pushTaskQuizStep(CreateSubtasksQuizRoute.staticBaseName, this);
    }
  }

  @override
  void finish() {
    _goal.creating = false;
    router.popToTaskType(TType.GOAL.toLowerCase());
  }
}

abstract class _CreateGoalQuizControllerBase extends AbstractTaskQuizController with Store {
  _CreateGoalQuizControllerBase(super.taskController);

  Task get _goal => taskController.task;

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.goalSetup.name, loc.goal_create_quiz_title, loc.next_action_title),
        if (!_goal.hmTaskboard) QuizStep(_StepCode.tasks.name, loc.task_multi_create_quiz_title, ''),
      ];
}
