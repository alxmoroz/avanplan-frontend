// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/goal.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/goal_status.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../_base/smartable_controller.dart';

part 'goal_edit_controller.g.dart';

class GoalEditController extends _GoalEditControllerBase with _$GoalEditController {}

abstract class _GoalEditControllerBase extends SmartableController<GoalStatus> with Store {
  Goal? get goal => mainController.selectedGoal;

  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(goal?.dueDate);
    setClosed(goal?.closed);
  }

  @computed
  bool get canEdit => goal != null;

  @override
  bool get allNeedFieldsTouched => super.allNeedFieldsTouched || (canEdit && selectedDueDate != null && anyFieldTouched);

  /// статусы

  @action
  Future fetchStatuses() async {
    statuses = ObservableList.of(await goalStatusesUC.getStatuses());
    sortStatuses();
    selectStatus(goal?.status);
  }

  /// действия

  //TODO: как вариант вызовы юзкейсов этих должны быть из главного контроллера
  Future saveGoal(BuildContext context) async {
    final editedGoal = await goalsUC.save(GoalUpsert(
      id: goal?.id,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      closed: closed,
      dueDate: selectedDueDate,
      statusId: selectedStatusId,
    ));

    if (editedGoal != null) {
      Navigator.of(context).pop(editedGoal);
    }
  }

  Future deleteGoal(BuildContext context) async {
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
        Navigator.of(context).pop(await goalsUC.delete(goal: goal!));
      }
    }
  }
}
