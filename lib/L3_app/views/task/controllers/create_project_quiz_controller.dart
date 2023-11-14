// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/views/my_projects/my_projects_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/feature_set.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_tree.dart';
import '../../../usecases/ws_tasks.dart';
import '../../quiz/quiz_controller.dart';
import '../task_view.dart';
import '../widgets/create/create_multitask_quiz_view.dart';
import '../widgets/create/create_task_quiz_view.dart';
import '../widgets/feature_sets/feature_sets.dart';
import '../widgets/project_statuses/project_statuses.dart';
import '../widgets/team/team_invitation_quiz_view.dart';
import 'feature_sets_controller.dart';
import 'task_controller.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, featureSets, statuses, team, goals, tasks }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(TaskController taskController) {
    _taskController = taskController;
  }

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
      await FeatureSetsQuizViewRouter().navigate(context, args: FSQuizArgs(_fsController!, this));
    } else if (step.code == _StepCode.statuses.name) {
      if (_taskController.projectStatusesController.sortedStatuses.isEmpty) {
        _taskController.projectStatusesController.createDefaults();
      }
      await Navigator.of(context).pushNamed(
        ProjectStatusesQuizView.routeName,
        arguments: PSQuizArgs(_taskController.projectStatusesController, this),
      );
    } else if (step.code == _StepCode.team.name) {
      await Navigator.of(context).pushNamed(TeamInvitationQuizView.routeName, arguments: TIQuizArgs(_taskController, this));
    } else if (step.code == _StepCode.goals.name) {
      if (_goalController == null) {
        final goal = await _project.ws.createTask(_project);
        if (goal != null) {
          _goalController = TaskController(goal, allowDisposeFromView: false);
        }
      }
      if (_goalController != null) {
        await CreateGoalQuizViewRouter().navigate(context, args: CreateTaskQuizArgs(_goalController!, this));
      }
    } else if (step.code == _StepCode.tasks.name) {
      await CreateMultiTaskQuizViewRouter().navigate(context, args: CreateMultiTaskQuizArgs(_goalController ?? _taskController, this));
    }
  }

  @override
  Future afterFinish(BuildContext context) async {
    Navigator.of(context).popUntil((r) => r.navigator?.canPop() != true);
    MyProjectsViewRouter().navigate(context);
    //TODO: нужно ли в этом месте создавать контроллер, может, тут достаточно отправить айдишники?
    //TODO: проверить необходимость await. Раньше не было тут. Если не надо, то оставить коммент почему не надо
    await TaskViewRouter().navigate(context, args: TaskController(_project));

    _goalController?.dispose();
  }
}

abstract class _CreateProjectQuizControllerBase extends QuizController with Store {
  late final TaskController _taskController;
  Task get _project => _taskController.task;

  TaskController? _goalController;
  @observable
  FeatureSetsController? _fsController;
  @computed
  bool get _hasTeam => _fsController?.hasChecked(FSCode.TEAM) == true;
  @computed
  bool get _hasGoals => _fsController?.hasChecked(FSCode.GOALS) == true;
  @computed
  bool get _hasBoard => _fsController?.hasChecked(FSCode.TASKBOARD) == true;

  @override
  Iterable<QuizStep> get steps => [
        QuizStep(_StepCode.projectSetup.name, '', loc.next_action_title),
        QuizStep(_StepCode.featureSets.name, loc.feature_sets_quiz_title, loc.next_action_title),
        if (_hasBoard) QuizStep(_StepCode.statuses.name, loc.status_quiz_title, loc.next_action_title),
        if (_hasTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title, loc.next_action_title),
        if (_hasGoals) QuizStep(_StepCode.goals.name, loc.goal_create_quiz_title, loc.next_action_title),
        QuizStep(_StepCode.tasks.name, _project.subtasks.isNotEmpty ? loc.task_multi_create_quiz_title : '$_project', ''),
      ];
}
