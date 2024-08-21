// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_repeat.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../components/field_data.dart';
import '../../../_base/edit_controller.dart';

part 'repeat_controller.g.dart';

class RepeatController extends _Base with _$RepeatController {
  RepeatController(Task task) {
    _task = task;
    reload();
  }
}

abstract class _Base extends EditController with Store {
  late final Task _task;

  @observable
  TaskRepeat repeat = TaskRepeat(wsId: -1, taskId: -1, periodType: TRPeriodType.DAILY.name, periodLength: 1, daysList: '');

  @action
  void setPeriodType(String? pt) {
    if (pt != null && pt != repeat.periodType) {
      repeat = repeat.copyWith(periodType: pt);
      final days = (repeat.daily
              ? ['']
              : repeat.weekly
                  ? weekdays
                  : daysOfMonth)
          .join(',');
      repeat = repeat.copyWith(daysList: days);
    }
  }

  @computed
  bool get weekly => repeat.weekly;
  @computed
  bool get monthly => repeat.monthly;

  @action
  void setPeriodLength(String? plStr) {
    if (plStr != null && plStr.isNotEmpty) {
      final pl = int.parse(plStr);
      if (pl != repeat.periodLength) {
        repeat = repeat.copyWith(periodLength: pl);
      }
    }
  }

  @action
  void _setDays(String? day, ObservableList<String> obsDays) {
    if (day != null) {
      if (obsDays.contains(day)) {
        obsDays.remove(day);
      } else {
        obsDays.add(day);
      }
      repeat = repeat.copyWith(daysList: obsDays.join(','));
    }
  }

  @observable
  ObservableList<String> weekdays = ObservableList();
  void selectWeekday(String? wd) => _setDays(wd, weekdays);

  @observable
  ObservableList<String> daysOfMonth = ObservableList();
  void selectDayOfMonth(String? day) => _setDays(day, daysOfMonth);

  @computed
  bool get canSave =>
      (repeat.daily || (repeat.weekly && weekdays.isNotEmpty) || (repeat.monthly && daysOfMonth.isNotEmpty)) &&
      repeat.periodLength > 0 &&
      fData(0).text.isNotEmpty;

  int get _defaultWeekday => _task.dueDate?.weekday ?? now.weekday;
  int get _defaultDayOfMonth {
    int day = _task.dueDate?.day ?? now.day;
    if (day > 28) day = -1;
    return day;
  }

  @action
  void reload() {
    initState(fds: [MTFieldData(0, text: '${_task.repeat?.periodLength ?? 1}', validate: true)]);

    repeat = _task.repeat != null ? _task.repeat! : repeat.copyWith(taskId: _task.id!, wsId: _task.wsId);

    final rDays = repeat.daysList.split(',');

    weekdays = ObservableList.of(repeat.weekly && rDays.isNotEmpty ? rDays : ['$_defaultWeekday']);
    daysOfMonth = ObservableList.of(repeat.monthly && rDays.isNotEmpty ? rDays : ['$_defaultDayOfMonth']);
  }
}
