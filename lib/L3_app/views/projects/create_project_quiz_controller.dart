// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/feature_set.dart';
import '../../../L1_domain/entities/task.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/task_tree.dart';
import '../../usecases/ws_tasks.dart';
import '../quiz/abstract_quiz_controller.dart';
import '../quiz/abstract_task_quiz_controller.dart';
import '../task/controllers/feature_sets_controller.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, featureSets, team, goals, tasks }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(super.taskController);

  @override
  Future beforeNext(BuildContext context) async {
    if (step.code == _StepCode.featureSets.name) {
      await _fsController.setup();
    }
  }

  @override
  Future afterNext(BuildContext context) async {
    if (step.code == _StepCode.featureSets.name) {
      _fsController.reload();
      context.goFeatureSetsQuiz(_project, this);
    } else if (step.code == _StepCode.team.name) {
      context.goTeamQuiz(_project, this);
    } else if (step.code == _StepCode.goals.name) {
      _goal ??= await _project.ws.createTask(_project);
      if (_goal != null && context.mounted) {
        context.goLocalTask(_goal!, extra: this);
      }
    } else if (step.code == _StepCode.tasks.name) {
      context.goSubtasksQuiz(_goal ?? _project, this);
    }
  }

  @override
  Future afterFinish(BuildContext context) async {
    // TODO: достаточно убрать из пути подразделы, если они там есть. Посмотреть в сторону ShellRoute для квиза.
    context.goLocalTask(_project);
  }
}

abstract class _CreateProjectQuizControllerBase extends AbstractTaskQuizController with Store {
  _CreateProjectQuizControllerBase(super.taskController);

  Task get _project => taskController.task!;
  Task? _goal;

  FeatureSetsController get _fsController => taskController.featureSetsController;

  bool get _hasTeam => _fsController.hasChecked(FSCode.TEAM) == true;
  bool get _hasGoals => _fsController.hasChecked(FSCode.GOALS) == true;
  bool get _hasBoard => _fsController.hasChecked(FSCode.TASKBOARD) == true;

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.projectSetup.name, '', loc.next_action_title),
        QuizStep(_StepCode.featureSets.name, loc.feature_sets_quiz_title, loc.next_action_title),
        if (_hasTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title, loc.next_action_title),
        if (_hasGoals) QuizStep(_StepCode.goals.name, loc.goal_create_quiz_title, loc.next_action_title),
        if (!_hasBoard) QuizStep(_StepCode.tasks.name, _project.subtasks.isNotEmpty ? loc.task_multi_create_quiz_title : '$_project', ''),
      ];
}
