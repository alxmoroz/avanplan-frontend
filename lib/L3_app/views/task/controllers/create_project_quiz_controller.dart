// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/feature_set.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_tasks.dart';
import '../../_base/quiz_controller.dart';
import '../task_view.dart';
import '../widgets/create/create_task_quiz_view.dart';
import '../widgets/feature_sets/feature_sets.dart';
import '../widgets/team/team_invitation_view.dart';
import 'feature_sets_controller.dart';
import 'task_controller.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, featureSets, team, goals }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(this._taskController) {
    active = project.isProject && project.isNew;
  }
  final TaskController _taskController;

  TaskController? _goalController;

  Task get project => _taskController.task;

  @override
  Future afterBack(BuildContext context) async {
    if (stepIndex == 0) {
      _goalController?.dispose();
    }
  }

  @override
  Future beforeNext(BuildContext context) async {
    if (step.code == _StepCode.featureSets.name) {
      await _fsController?.setup();
    }
  }

  @override
  Future afterNext(BuildContext context) async {
    if (step.code == _StepCode.featureSets.name) {
      _fsController ??= FeatureSetsController(_taskController);
      await Navigator.of(context).pushNamed(FeatureSetsQuizView.routeName, arguments: FSQuizArgs(_fsController!, this));
    } else if (step.code == _StepCode.team.name) {
      await Navigator.of(context).pushNamed(TeamInvitationQuizView.routeName, arguments: TIQuizArgs(_taskController, this));
    } else if (step.code == _StepCode.goals.name) {
      if (_goalController == null) {
        final goal = await project.ws.createTask(project);
        if (goal != null) {
          _goalController = TaskController(goal, allowDisposeFromView: false);
        }
      }
      await _goalController?.showCreateTaskQuiz(CreateTaskQuizView.routeNameGoal, context, this);
    }
  }

  @override
  Future afterFinish(BuildContext context) async {
    Navigator.of(context).popUntil((r) => r.settings.name == CreateTaskQuizView.routeNameProject || r.navigator?.canPop() != true);
    Navigator.of(context).pushReplacementNamed(TaskView.routeName, arguments: TaskController(project));

    _goalController?.dispose();
  }
}

abstract class _CreateProjectQuizControllerBase extends QuizController with Store {
  @observable
  FeatureSetsController? _fsController;
  @computed
  bool get _hasTeam => _fsController?.hasChecked(FSCode.TEAM) == true;
  @computed
  bool get _hasGoals => _fsController?.hasChecked(FSCode.GOALS) == true;

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.projectSetup.name, '', loc.next_action_title),
        QuizStep(_StepCode.featureSets.name, loc.feature_sets_quiz_title, loc.next_action_title),
        if (_hasTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title, loc.next_action_title),
        if (_hasGoals) QuizStep(_StepCode.goals.name, loc.goal_create_quiz_title, loc.next_action_title),
      ];
}
