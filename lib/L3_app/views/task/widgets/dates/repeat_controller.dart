// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_repeat.dart';

part 'repeat_controller.g.dart';

class RepeatController extends _Base with _$RepeatController {
  RepeatController(Task task) {
    _task = task;
    reload();
  }
}

abstract class _Base with Store {
  late final Task _task;
  late final TextEditingController teController;

  @observable
  TaskRepeat repeat = TaskRepeat(wsId: -1, taskId: -1, periodType: TRPeriodType.DAILY.name, periodLength: 1, daysList: '');

  @action
  void setPeriodType(String? pt) {
    if (pt != null) repeat = repeat.copyWith(periodType: pt);
  }

  @action
  void setPeriodLength(String? pl) {
    if (pl != null && pl.isNotEmpty) repeat = repeat.copyWith(periodLength: int.parse(pl));
  }

  @action
  void setDaysList(Set<int>? dl) {
    if (dl != null && dl.isNotEmpty) repeat = repeat.copyWith(daysList: dl.join(','));
  }

  @computed
  bool get canSave =>
      (repeat.periodType == TRPeriodType.DAILY.name || repeat.daysList.isNotEmpty) && repeat.periodLength > 0 && teController.text.isNotEmpty;

  @action
  void reload() {
    repeat = _task.repeat != null ? _task.repeat! : repeat.copyWith(taskId: _task.id!, wsId: _task.wsId);
    teController = TextEditingController(text: '${repeat.periodLength}');
  }
}
