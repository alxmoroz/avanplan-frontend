// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_tree.dart';
import '../../promo/promo_features.dart';
import '../../quiz/abstract_quiz_controller.dart';
import '../../quiz/abstract_task_quiz_controller.dart';
import '../usecases/edit.dart';
import '../usecases/project_modules.dart';
import '../widgets/project_modules/project_modules.dart';
import '../widgets/team/project_team_quiz_view.dart';
import 'project_modules_controller.dart';
import 'task_controller.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, projectModules, team, goals }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(super.taskController);

  @observable
  TaskController? _goalController;

  @action
  Future _addGoal() async => _goalController = await taskController.addSubtask(noGo: true);

  @override
  Future beforeNext() async {
    if (step.code == _StepCode.projectModules.name) await taskController.setupProjectModules();
  }

  @override
  Future afterNext() async {
    if (step.code == _StepCode.projectModules.name) {
      await showPromoFeatures(_project.ws);
      _pmc.reload();
      await router.pushTaskQuizStep(ProjectModulesQuizRoute.staticBaseName, this);
    } else if (step.code == _StepCode.team.name) {
      await router.pushTaskQuizStep(ProjectTeamQuizRoute.staticBaseName, this);
    } else if (step.code == _StepCode.goals.name) {
      if (_goalController == null) await _addGoal();
      if (_goalController != null) await router.pushTaskQuizStep('goal', this, pathParameters: {'goalId': '${_goalController!.taskDescriptor.id}'});
    }
  }

  @override
  void finish() {
    _project.creating = false;
    router.popToTaskTypeOrMain(TType.PROJECT);
  }
}

abstract class _CreateProjectQuizControllerBase extends AbstractTaskQuizController with Store {
  _CreateProjectQuizControllerBase(super.taskController);

  Task get _project => taskController.task;

  ProjectModulesController get _pmc => taskController.projectModulesController;

  bool get _wantTeam => taskController.hasProjectModuleChecked(TOCode.TEAM);
  bool get _wantGoals => taskController.hasProjectModuleChecked(TOCode.GOALS);
  // bool get _wantBoard => _pmc.hasChecked(TOCode.TASKBOARD);

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.projectSetup.name, ''),
        QuizStep(_StepCode.projectModules.name, loc.project_modules_quiz_title),
        if (_wantTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title),
        if (_wantGoals) QuizStep(_StepCode.goals.name, loc.goal_create_quiz_title),
      ];
}
