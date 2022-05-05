// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/goal.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../_base/smartable_controller.dart';
import 'goal_edit_view.dart';
import 'goal_view.dart';

part 'goal_controller.g.dart';

class GoalController extends _GoalControllerBase with _$GoalController {}

abstract class _GoalControllerBase extends SmartableController with Store {
  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(selectedGoal?.dueDate);
    setClosed(selectedGoal?.closed);
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
  Goal? get selectedGoal => mainController.goals.firstWhereOrNull((g) => g.id == selectedGoalId);

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
      mainController.updateGoalInList(goal);
      if (goal.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
