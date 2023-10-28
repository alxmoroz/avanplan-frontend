// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/field.dart';
import '../../../components/icons.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/date.dart';
import '../../../presenters/duration.dart';
import '../../../usecases/task_actions.dart';
import 'task_controller.dart';

class DatesController {
  DatesController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  Future _setStartDate(DateTime? _date) async {
    final oldValue = task.startDate;
    if (task.startDate != _date) {
      task.startDate = _date;
      if (!(await _taskController.saveField(TaskFCode.startDate))) {
        task.startDate = oldValue;
      }
    }
  }

  Future _setDueDate(DateTime? _date) async {
    final oldValue = task.dueDate;
    if (task.dueDate != _date) {
      task.dueDate = _date;
      if (!(await _taskController.saveField(TaskFCode.dueDate))) {
        task.dueDate = oldValue;
      }
    }
  }

  void _reset(TaskFCode code) {
    if (code == TaskFCode.startDate) {
      _setStartDate(null);
    } else if (code == TaskFCode.dueDate) {
      _setDueDate(null);
    }
  }

  Future selectDate(BuildContext context, TaskFCode code) async {
    final isStart = code == TaskFCode.startDate;

    final hasFutureStart = task.startDate != null && task.startDate!.isAfter(today);
    final selectedDate = isStart ? task.startDate : task.dueDate;

    final pastDate = today.subtract(year * 100);
    final futureDate = today.add(year * 100);

    final initialDate = selectedDate ?? (hasFutureStart ? task.startDate! : today);
    final firstDate = isStart ? pastDate : task.startDate ?? today;
    final lastDate = (isStart ? task.dueDate : null) ?? futureDate;

    // !! Нельзя давать менять способ ввода - поплывёт кнопка "Сбросить".
    // Если нужен ввод с клавиатуры, то нужно доработать позиционирование кнопки "Сбросить"
    // final entryMode = isWeb ? DatePickerEntryMode.input : DatePickerEntryMode.calendar;
    const entryMode = DatePickerEntryMode.calendarOnly;

    final date = await showDatePicker(
      context: context,
      initialEntryMode: entryMode,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (_, child) => LayoutBuilder(
        builder: (ctx, size) {
          final isPortrait = size.maxHeight > size.maxWidth;
          return Stack(
            children: [
              child!,
              if (selectedDate != null)
                Positioned(
                  left: size.maxWidth / 2 - (isPortrait ? 140 : 60),
                  top: size.maxHeight / 2 + (isPortrait ? 220 : 126),
                  child: MTButton(
                      middle: SmallText(loc.clear_action_title, color: dangerColor),
                      onTap: () {
                        Navigator.of(ctx).pop();
                        _reset(code);
                      }),
                ),
            ],
          );
        },
      ),
    );

    if (date != null) {
      if (isStart) {
        _setStartDate(date);
      } else {
        _setDueDate(date);
      }
    }
  }

  Widget dateField(BuildContext context, TaskFCode code) {
    final isStart = code == TaskFCode.startDate;
    final date = isStart ? task.startDate : task.dueDate;
    final isEmpty = date == null;
    final fd = _taskController.fData(code.index);
    return MTField(
      fd,
      leading: isStart ? CalendarIcon(color: task.canEdit ? mainColor : f2Color) : Container(),
      value: !isEmpty
          ? Row(children: [
              BaseText(date.strMedium, padding: const EdgeInsets.only(right: P), maxLines: 1),
              BaseText.f2(DateFormat.EEEE().format(date), maxLines: 1),
            ])
          : null,
      onSelect: task.canEdit ? () => selectDate(context, code) : null,
      bottomDivider: isStart && (task.hasDueDate || task.canEdit),
      dividerStartIndent: isStart ? P * 11 : null,
    );
  }
}
