// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_tree.dart';
import '../../my_projects/my_projects_view.dart';
import '../../quiz/quiz_controller.dart';
import '../task_view.dart';
import '../widgets/create/create_multitask_quiz_view.dart';
import 'task_controller.dart';

part 'create_goal_quiz_controller.g.dart';

enum _StepCode {
  goalSetup,
  tasks,
}

class CreateGoalQuizController extends _CreateGoalQuizControllerBase with _$CreateGoalQuizController {
  CreateGoalQuizController(TaskController goalController) {
    _goalController = goalController;
  }

  @override
  Future afterNext(BuildContext context) async {
    if (step.code == _StepCode.tasks.name) {
      await CreateMultiTaskQuizRouter().navigate(context, args: CreateMultiTaskQuizArgs(_goalController, this));
    }
  }

  @override
  Future afterFinish(BuildContext context) async {
    Navigator.of(context).popUntil((r) => r.navigator?.canPop() != true);
    MyProjectsRouter().navigate(context);
    TaskRouter().navigate(context, args: TaskController(_goal.project!));
    //TODO: нужно ли в этом месте создавать контроллер, может, тут достаточно отправить айдишники?
    //TODO: проверить необходимость await. Раньше не было тут. Если не надо, то оставить коммент почему не надо
    TaskRouter().navigate(context, args: TaskController(_goal));
  }
}

abstract class _CreateGoalQuizControllerBase extends QuizController with Store {
  late final TaskController _goalController;

  Task get _goal => _goalController.task;

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.goalSetup.name, loc.goal_create_quiz_title, loc.next_action_title),
        QuizStep(_StepCode.tasks.name, _goal.subtasks.isNotEmpty ? loc.task_multi_create_quiz_title : '$_goal', ''),
      ];
}
