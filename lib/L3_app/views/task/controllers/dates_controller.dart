// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/duration.dart';
import 'task_controller.dart';

class DatesController {
  DatesController(this._taskController);
  final TaskController _taskController;

  Task get _task => _taskController.task!;

  Future _setStartDate(DateTime? date) async {
    final oldValue = _task.startDate;
    if (_task.startDate != date) {
      _task.startDate = date;
      if (!(await _taskController.saveField(TaskFCode.startDate))) {
        _task.startDate = oldValue;
      }
    }
  }

  Future _setDueDate(DateTime? date) async {
    final oldValue = _task.dueDate;
    if (_task.dueDate != date) {
      _task.dueDate = date;
      if (!(await _taskController.saveField(TaskFCode.dueDate))) {
        _task.dueDate = oldValue;
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

    final hasFutureStart = _task.startDate != null && _task.startDate!.isAfter(today);
    final selectedDate = isStart ? _task.startDate : _task.dueDate;

    final pastDate = today.subtract(year * 100);
    final futureDate = today.add(year * 100);

    final initialDate = selectedDate ?? (hasFutureStart ? _task.startDate! : today);
    final firstDate = isStart ? pastDate : _task.startDate ?? today;
    final lastDate = (isStart ? _task.dueDate : null) ?? futureDate;

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
}
