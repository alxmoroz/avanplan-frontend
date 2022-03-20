// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../_base/base_controller.dart';

part 'goal_edit_controller.g.dart';

class GoalEditController extends _GoalEditControllerBase with _$GoalEditController {}

abstract class _GoalEditControllerBase extends BaseController with Store {
  Goal? get goal => mainController.selectedGoal;

  @override
  void initState(BuildContext _context, {List<TFAnnotation>? tfaList}) {
    super.initState(_context, tfaList: tfaList);
    setDueDate(goal?.dueDate);
  }

  @override
  bool get validated => super.validated || (canEdit && selectedDueDate != null && anyFieldHasTouched);

  @observable
  DateTime? selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    controllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }

  @computed
  bool get canEdit => goal != null;

  Future saveGoal() async {
    final editedGoal = await goalsUC.saveGoal(
      id: goal?.id,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      dueDate: selectedDueDate,
    );

    if (editedGoal != null) {
      Navigator.of(context!).pop(editedGoal);
    }
  }

  Future deleteGoal() async {
    if (canEdit) {
      final confirm = await showMTDialog<bool?>(
        context!,
        title: loc.goal_delete_dialog_title,
        description: '${loc.goal_delete_dialog_description}\n${loc.common_delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.common_yes, isDestructive: true, result: true),
          MTDialogAction(title: loc.common_no, isDefault: true, result: false),
        ],
      );
      if (confirm != null && confirm) {
        Navigator.of(context!).pop(await goalsUC.deleteGoal(goal!));
      }
    }
  }
}
