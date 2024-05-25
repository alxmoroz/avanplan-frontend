// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_feature_sets.dart';
import '../../../usecases/task_tree.dart';
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
      router.goTaskQuizStep(CreateSubtasksQuizRoute.staticBaseName, this);
    }
  }

  @override
  void afterFinish() {
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
        if (!_goal.hfsTaskboard) QuizStep(_StepCode.tasks.name, _goal.subtasks.isNotEmpty ? loc.task_multi_create_quiz_title : '$_goal', ''),
      ];
}
