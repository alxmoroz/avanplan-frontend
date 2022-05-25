// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/goal_upsert.dart';
import '../../../L1_domain/entities/auth/workspace.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../element_of_work/ew_edit_controller.dart';
import 'goal_edit_view.dart';
import 'goal_view.dart';

part 'goal_controller.g.dart';

class GoalController extends _GoalControllerBase with _$GoalController {}

abstract class _GoalControllerBase extends EWEditController with Store {
  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(selectedGoal?.dueDate);
    setClosed(selectedGoal?.closed);
  }

  /// цели - рутовый объект

  // TODO: здесь можно заменить на Smartable для подзадач и использовать в дашборде задач и цели. И перенести в контроллер Smartable

  @observable
  ObservableList<Goal> goals = ObservableList();

  @action
  void _sortGoals() => goals.sort((g1, g2) => g1.title.compareTo(g2.title));

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

  @action
  Future fetchData() async {
    startLoading();
    clearData();
    for (Workspace ws in mainController.workspaces) {
      goals.addAll(ws.goals);
    }
    _sortGoals();
    stopLoading();
  }

  @action
  void clearData() => goals.clear();

  /// выбранная цель

  @observable
  int? selectedGoalId;

  @action
  void selectGoal(Goal? _goal) {
    selectedGoalId = _goal?.id;
    selectWS(_goal?.workspaceId);
  }

  // TODO: из текущего фильтра?
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
    await Navigator.of(context).pushNamed(GoalView.routeName);
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
