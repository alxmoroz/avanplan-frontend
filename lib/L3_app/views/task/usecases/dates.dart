// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../L1_domain/utils/dates.dart';
import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension DatesUC on TaskController {
  Future _setStartDate(DateTime? date) async {
    final oldValue = task.startDate;
    if (task.startDate != date) {
      task.startDate = date;
      if (!(await saveField(TaskFCode.startDate))) {
        task.startDate = oldValue;
      }
    }
  }

  Future _setDueDate(DateTime? date) async {
    final oldValue = task.dueDate;
    if (task.dueDate != date) {
      task.dueDate = date;
      if (!(await saveField(TaskFCode.dueDate))) {
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

    final startDate = task.startDate;
    final dueDate = task.dueDate;

    final hasFutureStart = startDate != null && startDate.isAfter(today);
    final selectedDate = isStart ? startDate : dueDate;

    final pastDate = today.subtract(YEAR * 100);
    final futureDate = today.add(YEAR * 100);

    final initialDate = selectedDate ?? (hasFutureStart ? startDate : today);
    final firstDate = isStart ? pastDate : startDate ?? today;
    final lastDate = (isStart ? dueDate : null) ?? futureDate;

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
                      middle: SmallText(loc.action_clear_title, color: dangerColor),
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
