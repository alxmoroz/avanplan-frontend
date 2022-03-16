// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L3_app/extra/services.dart';
import '../../components/text_field_annotation.dart';
import '../../presenters/date_presenter.dart';
import '../_base/base_controller.dart';

part 'goal_controller.g.dart';

class GoalController extends _GoalControllerBase with _$GoalController {}

abstract class _GoalControllerBase extends BaseController with Store {
  @override
  void initState(BuildContext _context, {List<TFAnnotation>? tfaList}) {
    super.initState(_context, tfaList: tfaList);
    setDueDate(goal?.dueDate);
    setEditMode(goal == null);
  }

  @override
  bool get validated => super.validated || (goal != null && selectedDueDate != null && anyFieldHasTouched);

  @observable
  Goal? goal;

  @action
  void setGoal(Goal? _goal) => goal = _goal;

  @observable
  DateTime? selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    controllers['dueDate']?.text = dateToString(_date);
  }

  @computed
  bool get canDelete => goal != null;

  Future saveGoal() async {
    final editedGoal = await goalsUC.saveGoal(
      id: goal?.id,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      dueDate: selectedDueDate,
    );

    if (editedGoal != null) {
      setGoal(editedGoal);
      setEditMode(false);
    } else {
      //TODO: может быть внутреняя или серверная. Например, нет ответа от сервера...
      print('Ошибка saveGoal');
    }
  }

  Future deleteGoal() async {
    if (await goalsUC.deleteGoal(goal)) {
      Navigator.of(context!).pop();
      // TODO: уже удалилось, но в списке целей ещё отображается. Может, не надо перезагружать все цели каждый раз в списке на главной?
      //  Ну и то же самое про добавление... Тут, может, как раз поможет локальное хранилище?
    } else {
      print('Ошибка deleteGoal');
    }
  }
}
