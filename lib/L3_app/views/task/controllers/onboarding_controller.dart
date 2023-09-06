// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../usecases/task_feature_sets.dart';
import '../task_view.dart';
import '../widgets/team/team_pane.dart';
import 'task_controller.dart';

part 'onboarding_controller.g.dart';

enum _TaskOnboardingStep { team, goals, tasks }

class OnboardingController extends _OnboardingControllerBase with _$OnboardingController {
  OnboardingController(TaskController _taskController) {
    taskController = _taskController;
    // TODO: хранить инфу о режиме онбординга в проекте (добавить поле на фронте)
    onboarding = taskController.task.isNew && taskController.task.isProject;
  }
}

abstract class _OnboardingControllerBase with Store {
  late final TaskController taskController;

  Iterable<_TaskOnboardingStep> get _steps => [
        if (taskController.task.hfsTeam) _TaskOnboardingStep.team,
        if (taskController.task.hfsGoals) _TaskOnboardingStep.goals,
        _TaskOnboardingStep.tasks,
      ];

  int get stepsCount => _steps.length;

  @observable
  bool onboarding = false;

  @observable
  int stepIndex = -1;

  @computed
  _TaskOnboardingStep get _step => _steps.elementAt(stepIndex);

  @computed
  bool get lastStep => stepIndex == stepsCount - 1;

  @action
  Future next(BuildContext context) async {
    stepIndex++;
    if (_step == _TaskOnboardingStep.team) {
      await Navigator.of(context).pushNamed(TeamInvitationOnboardingPage.routeName, arguments: this);
      stepIndex--;
    } else if (_step == _TaskOnboardingStep.goals) {
      // TODO: разнести создание и обработку возврата из пуша (может и не понадобится, если мы будем брать признак онбординга из проекта
      // TODO: в любом случае заголовок будет отличаться и добавляется кнопка там же, где настройка модулей в проекте, но для цели это бдует продолжить.
      // TODO: либо эту кнопку вынести в футер? - тогда надо, чтобы футер поднимался выше клавиатуры...

      // await CreateController(taskController.task.ws, taskController).create();
      print('GOALS');
      stepIndex--;
    } else if (_step == _TaskOnboardingStep.tasks) {
      print('TASKS');
      stepIndex--;
    }
  }

  @action
  void finish(BuildContext context) {
    // TODO: учесть с какого шага и куда
    Navigator.of(context).popUntil((r) => r.navigator?.canPop() == true && r.settings.name == TaskView.routeName);
    onboarding = false;
    stepIndex = -1;
  }
}
