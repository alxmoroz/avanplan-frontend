// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/goal.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/goal_status.dart';
import '../../components/confirmation_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../_base/base_controller.dart';

part 'goal_edit_controller.g.dart';

class GoalEditController extends _GoalEditControllerBase with _$GoalEditController {}

abstract class _GoalEditControllerBase extends BaseController with Store {
  Goal? get goal => mainController.selectedGoal;

  @override
  bool get allNeedFieldsTouched => super.allNeedFieldsTouched || (canEdit && selectedDueDate != null && anyFieldTouched);

  /// статусы

  @observable
  ObservableList<GoalStatus> statuses = ObservableList();

  @action
  void _sortStatuses() {
    statuses.sort((s1, s2) => s1.title.compareTo(s2.title));
  }

  @action
  Future fetchGoalStatuses() async {
    statuses = ObservableList.of(await goalStatusesUC.getStatuses());
    _sortStatuses();
    setDueDate(goal?.dueDate);
    selectStatus(goal?.status);
  }

  @observable
  int? selectedStatusId;

  @action
  void selectStatus(GoalStatus? _status) {
    selectedStatusId = _status?.id;
  }

  @computed
  GoalStatus? get selectedStatus => statuses.firstWhereOrNull((s) => s.id == selectedStatusId);

  /// дата

  @observable
  DateTime? selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    controllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }

  @computed
  bool get canEdit => goal != null;

  /// действия

  //TODO: как вариант вызовы юзкейсов этих должны быть из главного контроллера
  Future saveGoal(BuildContext context) async {
    final editedGoal = await goalsUC.save(GoalUpsert(
      id: goal?.id,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      dueDate: selectedDueDate,
      statusId: selectedStatusId,
      parentId: null,
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
