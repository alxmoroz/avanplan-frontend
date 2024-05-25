// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/feature_set.dart';
import '../../../L1_domain/entities/task.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../quiz/abstract_quiz_controller.dart';
import '../quiz/abstract_task_quiz_controller.dart';
import '../task/controllers/feature_sets_controller.dart';
import '../task/controllers/task_controller.dart';
import '../task/usecases/edit.dart';
import '../task/widgets/create/create_subtasks_quiz_view.dart';
import '../task/widgets/feature_sets/feature_sets.dart';
import '../task/widgets/team/team_quiz_view.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, featureSets, team, goals, tasks }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(super.taskController);

  @observable
  TaskController? _goalController;

  @action
  Future _addGoal() async {
    _goalController = await taskController.addSubtask(noGo: true);
    if (_goalController != null) {
      await router.pushTaskQuizStep('goal_${_goalController!.taskDescriptor.id}', this);
    }
  }

  @override
  Future beforeNext() async {
    if (step.code == _StepCode.featureSets.name) await _fsc.setup();
  }

  @override
  Future afterNext() async {
    if (step.code == _StepCode.featureSets.name) {
      _fsc.reload();
      await router.pushTaskQuizStep(FeatureSetsQuizRoute.staticBaseName, this);
    } else if (step.code == _StepCode.team.name) {
      await router.pushTaskQuizStep(TeamQuizRoute.staticBaseName, this);
    } else if (step.code == _StepCode.goals.name) {
      if (_goalController == null) await _addGoal();
    } else if (step.code == _StepCode.tasks.name) {
      await router.pushTaskQuizStep(CreateSubtasksQuizRoute.staticBaseName, this, needAppendPath: _goalController != null);
    }
  }

  @override
  void finish() {
    _project.creating = false;
    router.popToTaskType(TType.PROJECT.toLowerCase());
  }
}

abstract class _CreateProjectQuizControllerBase extends AbstractTaskQuizController with Store {
  _CreateProjectQuizControllerBase(super.taskController);

  Task get _project => taskController.task;

  FeatureSetsController get _fsc => taskController.featureSetsController;

  bool get _wantTeam => _fsc.hasChecked(FSCode.TEAM);
  bool get _wantGoals => _fsc.hasChecked(FSCode.GOALS);
  bool get _wantBoard => _fsc.hasChecked(FSCode.TASKBOARD);

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.projectSetup.name, '', loc.next_action_title),
        QuizStep(_StepCode.featureSets.name, loc.feature_sets_quiz_title, loc.next_action_title),
        if (_wantTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title, loc.next_action_title),
        if (_wantGoals) QuizStep(_StepCode.goals.name, loc.goal_create_quiz_title, loc.next_action_title),
        if (!_wantBoard) QuizStep(_StepCode.tasks.name, loc.task_multi_create_quiz_title, ''),
      ];
}
