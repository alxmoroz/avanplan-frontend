// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/tariff.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../quiz/abstract_quiz_controller.dart';
import '../../quiz/abstract_task_quiz_controller.dart';
import '../usecases/edit.dart';
import '../widgets/create/create_subtasks_quiz_view.dart';
import '../widgets/project_modules/project_modules.dart';
import '../widgets/team/team_quiz_view.dart';
import 'project_modules_controller.dart';
import 'task_controller.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, projectModules, team, goals, tasks }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(super.taskController);

  @observable
  TaskController? _goalController;

  @action
  Future _addGoal() async => _goalController = await taskController.addSubtask(noGo: true);

  @override
  Future beforeNext() async {
    if (step.code == _StepCode.projectModules.name) await _pmc.setup();
  }

  @override
  Future afterNext() async {
    if (step.code == _StepCode.projectModules.name) {
      _pmc.reload();
      await router.pushTaskQuizStep(ProjectModulesQuizRoute.staticBaseName, this);
    } else if (step.code == _StepCode.team.name) {
      await router.pushTaskQuizStep(TeamQuizRoute.staticBaseName, this);
    } else if (step.code == _StepCode.goals.name) {
      if (_goalController == null) await _addGoal();
      if (_goalController != null) await router.pushTaskQuizStep('goal', this, pathParameters: {'goalId': '${_goalController!.taskDescriptor.id}'});
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

  ProjectModulesController get _pmc => taskController.projectModulesController;

  bool get _wantTeam => _pmc.hasChecked(TOCode.TEAM);
  bool get _wantGoals => _pmc.hasChecked(TOCode.GOALS);
  bool get _wantBoard => _pmc.hasChecked(TOCode.TASKBOARD);

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.projectSetup.name, ''),
        QuizStep(_StepCode.projectModules.name, loc.project_modules_quiz_title),
        if (_wantTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title),
        if (_wantGoals) QuizStep(_StepCode.goals.name, loc.goal_create_quiz_title),
        if (!_wantBoard) QuizStep(_StepCode.tasks.name, loc.task_multi_create_quiz_title),
      ];
}
