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
import '../usecases/project_modules.dart';
import '../widgets/project_modules/project_modules.dart';
import '../widgets/team/project_team_quiz_view.dart';
import 'project_modules_controller.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, projectModules, team }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(super.taskController);

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

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.projectSetup.name, ''),
        QuizStep(_StepCode.projectModules.name, loc.project_modules_quiz_title),
        if (_wantTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title),
      ];
}
