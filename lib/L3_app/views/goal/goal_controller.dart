// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/goal_upsert.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../element_of_work/ew_edit_controller.dart';

part 'goal_controller.g.dart';

class GoalController extends _GoalControllerBase with _$GoalController {}

abstract class _GoalControllerBase extends EWEditController with Store {
  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(ewViewController.selectedGoal?.dueDate);
    setClosed(ewViewController.selectedGoal?.closed);
    selectWS(ewViewController.selectedGoal?.workspaceId);
  }

  @override
  @computed
  bool get canEdit => ewViewController.selectedGoal != null;

  @override
  bool get validated => super.validated && selectedDueDate != null && selectedWS != null;

  /// действия

  Future save(BuildContext context) async {
    final editedGoal = await goalsUC.save(GoalUpsert(
      id: ewViewController.selectedGoal?.id,
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
        description: '${loc.ew_delete_dialog_description}\n${loc.common_delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.common_yes, isDestructive: true, result: true),
          MTDialogAction(title: loc.common_no, isDefault: true, result: false),
        ],
      );
      if (confirm != null && confirm) {
        Navigator.of(context).pop(await goalsUC.delete(goal: ewViewController.selectedGoal!));
      }
    }
  }
}
