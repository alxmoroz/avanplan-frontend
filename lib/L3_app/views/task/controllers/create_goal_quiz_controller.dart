// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../quiz/abstract_quiz_controller.dart';
import '../../quiz/abstract_task_quiz_controller.dart';

part 'create_goal_quiz_controller.g.dart';

enum _StepCode { goalSetup }

class CreateGoalQuizController extends _CreateGoalQuizControllerBase with _$CreateGoalQuizController {
  CreateGoalQuizController(super.taskController);

  @override
  Future afterNext() async {}

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
        QuizStep(_StepCode.goalSetup.name, loc.goal_create_quiz_title),
      ];
}
