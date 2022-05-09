// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/goal.dart';
import '../../../L1_domain/entities/auth/workspace.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../_base/smartable_controller.dart';
import 'goal_dashboard_view.dart';
import 'goal_edit_view.dart';

part 'goal_controller.g.dart';

class GoalController extends _GoalControllerBase with _$GoalController {}

abstract class _GoalControllerBase extends SmartableController with Store {
  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(selectedGoal?.dueDate);
    setClosed(selectedGoal?.closed);
  }

  /// цели - рутовый объект

  @observable
  ObservableList<Goal> goals = ObservableList();

  @computed
  Iterable<Goal> get openedGoals => goals.where((g) => !g.closed);

  @computed
  Iterable<Goal> get timeBoundGoals => openedGoals.where((g) => g.dueDate != null);

  @computed
  Iterable<Goal> get overdueGoals => timeBoundGoals.where((g) => g.hasOverdue);

  @computed
  Iterable<Goal> get riskyGoals => timeBoundGoals.where((g) => g.hasRisk);

  @computed
  Iterable<Goal> get okGoals => timeBoundGoals.where((g) => g.ok);

  @computed
  Iterable<Goal> get noDueGoals => openedGoals.where((g) => g.dueDate == null);

  @computed
  Iterable<Goal> get activeGoals => openedGoals.where((g) => g.closedTasksCount > 0);

  @computed
  Iterable<Goal> get closableGoals => activeGoals.where((g) => g.lefTasksCount == 0);

  @computed
  Iterable<Goal> get inactiveGoals => openedGoals.where((g) => g.closedTasksCount == 0);

  @computed
  Duration get overduePeriod {
    int totalSeconds = 0;
    overdueGoals.forEach((g) => totalSeconds += g.overduePeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @computed
  Duration get riskPeriod {
    int totalSeconds = 0;
    riskyGoals.forEach((g) => totalSeconds += g.etaRiskPeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  @action
  void _sortGoals() {
    goals.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

  @action
  void updateGoalInList(Goal? _goal) {
    if (_goal != null) {
      final index = goals.indexWhere((g) => g.id == _goal.id);
      if (index >= 0) {
        if (_goal.deleted) {
          goals.remove(_goal);
        } else {
          goals[index] = _goal.copy();
        }
      } else {
        goals.add(_goal);
      }
      _sortGoals();
    }
  }

  @override
  Future fetchData() async {
    goals.clear();
    if (loginController.authorized) {
      startLoading();
      for (Workspace ws in workspaceController.workspaces) {
        goals.addAll(ws.goals);
      }
      _sortGoals();
      stopLoading();
    }
  }

  /// выбранная цель

  @observable
  int? selectedGoalId;

  @action
  void selectGoal(Goal? _goal) {
    selectedGoalId = _goal?.id;
    selectWS(_goal?.workspaceId);
  }

  @computed
  Goal? get selectedGoal => goals.firstWhereOrNull((g) => g.id == selectedGoalId);

  @override
  @computed
  bool get canEdit => selectedGoal != null;

  @override
  bool get validated => super.validated && selectedDueDate != null && selectedWS != null;

  /// действия

  Future save(BuildContext context) async {
    final editedGoal = await goalsUC.save(GoalUpsert(
      id: selectedGoal?.id,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      closed: closed,
      dueDate: selectedDueDate,
      workspaceId: selectedWS!.id,
    ));

    if (editedGoal != null) {
      Navigator.of(context).pop(editedGoal);
    }
  }

  @override
  Future delete(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTDialog<bool?>(
        context,
        title: loc.goal_delete_dialog_title,
        description: '${loc.goal_delete_dialog_description}\n${loc.common_delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.common_yes, isDestructive: true, result: true),
          MTDialogAction(title: loc.common_no, isDefault: true, result: false),
        ],
      );
      if (confirm != null && confirm) {
        Navigator.of(context).pop(await goalsUC.delete(goal: selectedGoal!));
      }
    }
  }

  /// роутер

  Future showGoal(BuildContext context, Goal goal) async {
    selectGoal(goal);
    await Navigator.of(context).pushNamed(GoalDashboardView.routeName);
  }

  Future addGoal(BuildContext context) async {
    editGoal(context, null);
  }

  Future editGoal(BuildContext context, Goal? selectedGoal) async {
    selectGoal(selectedGoal);
    final goal = await showEditGoalDialog(context);
    if (goal != null) {
      updateGoalInList(goal);
      if (goal.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
