// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/feature_set.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_tasks.dart';
import '../task_onboarding_view.dart';
import '../task_view.dart';
import '../widgets/details/feature_sets.dart';
import '../widgets/team/team_invitation_view.dart';
import 'feature_sets_controller.dart';
import 'task_controller.dart';

part 'onboarding_controller.g.dart';

enum _StepCode { projectSetup, featureSets, team, goals, tasks }

class _Step {
  _Step(this.code, this.title, this.nextButtonTitle);
  final _StepCode code;
  final String title;
  final String nextButtonTitle;
}

class OnboardingController extends _OnboardingControllerBase with _$OnboardingController {
  OnboardingController(TaskController taskController) {
    _taskController = taskController;
    onboarding = project.isProject && project.isNew;
  }

  Future back(BuildContext context) async {
    await _popBack(context);
  }

  Future next(BuildContext context) async {
    if (_lastStep) {
      finish(context);
      return;
    }
    if (_step.code == _StepCode.featureSets) {
      await _fsController?.setup();
    }
    await _pushNext(context, this);
  }
}

abstract class _OnboardingControllerBase with Store {
  late final TaskController _taskController;

  FeatureSetsController? _fsController;
  TaskController? _goalController;

  Task get project => _taskController.task;

  Iterable<_Step> get _steps => [
        _Step(_StepCode.projectSetup, '', loc.next_action_title),
        _Step(_StepCode.featureSets, loc.feature_sets_onboarding_title, loc.next_action_title),
        if (_fsController?.hasChecked(FSCode.TEAM) == true) _Step(_StepCode.team, loc.team_onboarding_title, loc.next_action_title),
        if (_fsController?.hasChecked(FSCode.GOALS) == true) _Step(_StepCode.goals, loc.goal_onboarding_title, loc.next_action_title),
        _Step(_StepCode.tasks, loc.task_onboarding_title, loc.finish_action_title),
      ];

  int get stepsCount => _steps.length;

  @observable
  bool onboarding = false;

  @observable
  int stepIndex = 0;

  @computed
  _Step get _step => _steps.elementAt(stepIndex);

  @computed
  bool get _lastStep => stepIndex == stepsCount - 1;

  @computed
  String get stepTitle => _step.title;

  @computed
  String get nextBtnTitle => onboarding ? _step.nextButtonTitle : '';

  @action
  Future _popBack(BuildContext context) async {
    if (stepIndex == 0) {
      _goalController?.dispose();
    }
    Navigator.of(context).pop();
  }

  @action
  Future _pushNext(BuildContext context, OnboardingController onbController) async {
    stepIndex++;
    if (_step.code == _StepCode.featureSets) {
      _fsController ??= FeatureSetsController(_taskController);
      await Navigator.of(context).pushNamed(FeatureSetsOnboardingView.routeName, arguments: FSOnboardingArgs(_fsController!, onbController));
    } else if (_step.code == _StepCode.team) {
      await Navigator.of(context).pushNamed(TeamInvitationOnboardingView.routeName, arguments: TIOnboardingArgs(_taskController, onbController));
    } else if (_step.code == _StepCode.goals) {
      if (_goalController == null) {
        final goal = await project.ws.createTask(project);
        if (goal != null) {
          _goalController = TaskController(goal, allowDisposeFromView: false);
        }
      }
      await _goalController?.showOnboardingTask(TaskOnboardingView.routeNameGoal, context, onbController);
    } else if (_step.code == _StepCode.tasks) {
      print('TASKS');
    }
    stepIndex--;
  }

  @action
  Future finish(BuildContext context) async {
    _goalController?.dispose();
    onboarding = false;
    stepIndex = 0;

    // TODO: учесть с какого шага и куда
    Navigator.of(context).popUntil((r) => r.settings.name == TaskOnboardingView.routeNameProject || r.navigator?.canPop() != true);
    Navigator.of(context).pushReplacementNamed(TaskView.routeName, arguments: TaskController(_taskController.task));
  }
}
