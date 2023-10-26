// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../quiz/quiz_controller.dart';
import '../task_view.dart';
import '../widgets/create/create_task_quiz_view.dart';
import 'task_controller.dart';

part 'create_goal_quiz_controller.g.dart';

enum _StepCode {
  goalSetup,
  // tasks,
}

class CreateGoalQuizController extends _CreateGoalQuizControllerBase with _$CreateGoalQuizController {
  CreateGoalQuizController(this._taskController);
  final TaskController _taskController;

  Task get _goal => _taskController.task;

  @override
  Future afterFinish(BuildContext context) async {
    Navigator.of(context).popUntil((r) => r.settings.name == CreateTaskQuizView.routeNameGoal || r.navigator?.canPop() != true);
    Navigator.of(context).pushReplacementNamed(TaskView.routeName, arguments: TaskController(_goal));
  }
}

abstract class _CreateGoalQuizControllerBase extends QuizController with Store {
  @override
  Iterable<QuizStep> get steps => [QuizStep(_StepCode.goalSetup.name, loc.goal_create_quiz_title, '')];
}
