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
import '../task/controllers/feature_sets_controller.dart';
import '../task/controllers/task_controller.dart';
import '../task/task_view.dart';
import '../task/widgets/create/create_multitask_quiz_view.dart';
import '../task/widgets/create/create_task_quiz_view.dart';
import '../task/widgets/feature_sets/feature_sets.dart';
import '../task/widgets/team/team_invitation_quiz_view.dart';
import 'projects_view.dart';

part 'create_project_quiz_controller.g.dart';

enum _StepCode { projectSetup, featureSets, team, goals, tasks }

class CreateProjectQuizController extends _CreateProjectQuizControllerBase with _$CreateProjectQuizController {
  CreateProjectQuizController(TaskController projectController) {
    _projectController = projectController;
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
      _fsController ??= FeatureSetsController(_projectController);
      await MTRouter.navigate(FeatureSetsQuizRouter, context, args: FSQuizArgs(_fsController!, this));
    } else if (step.code == _StepCode.team.name) {
      await MTRouter.navigate(TeamInvitationQuizRouter, context, args: TIQuizArgs(_projectController, this));
    } else if (step.code == _StepCode.goals.name) {
      if (_goalController == null) {
        final newGoal = await _project.ws.createTask(_project);
        if (newGoal != null) {
          _goalController = TaskController(newGoal, isNew: true, allowDisposeFromView: false);
        }
      }
      if (_goalController != null && context.mounted) {
        await MTRouter.navigate(CreateGoalQuizRouter, context, args: CreateTaskQuizArgs(_goalController!, this));
      }
    } else if (step.code == _StepCode.tasks.name) {
      await MTRouter.navigate(CreateMultiTaskQuizRouter, context, args: CreateMultiTaskQuizArgs(_goalController ?? _projectController, this));
    }
  }

  @override
  Future afterFinish(BuildContext context) async {
    Navigator.of(context).popUntil((r) => r.navigator?.canPop() != true);

    MTRouter.navigate(ProjectsRouter, context);
    //TODO: нужно ли в этом месте создавать контроллер, может, тут достаточно отправить айдишники?
    //TODO: проверить необходимость await. Раньше не было тут. Если не надо, то оставить коммент почему не надо
    await MTRouter.navigate(TaskRouter, context, args: TaskController(_project));

    _goalController?.dispose();
  }
}

abstract class _CreateProjectQuizControllerBase extends AbstractQuizController with Store {
  late final TaskController _projectController;
  Task get _project => _projectController.task!;

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
        if (_hasTeam) QuizStep(_StepCode.team.name, loc.team_quiz_title, loc.next_action_title),
        if (_hasGoals) QuizStep(_StepCode.goals.name, loc.goal_create_quiz_title, loc.next_action_title),
        if (!_hasBoard) QuizStep(_StepCode.tasks.name, _project.subtasks.isNotEmpty ? loc.task_multi_create_quiz_title : '$_project', ''),
      ];
}
