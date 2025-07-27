// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task_repeat.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../../app/services.dart';
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

  void resetDate(TaskFCode code) {
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

    final initialDate = selectedDate ?? (hasFutureStart ? startDate : (dueDate?.isBefore(today) == true ? dueDate : today));
    final firstDate = isStart ? pastDate : startDate ?? (initialDate?.isBefore(today) == true ? initialDate! : today);
    final lastDate = (isStart ? dueDate : null) ?? futureDate;

    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      if (isStart) {
        _setStartDate(date);
      } else {
        _setDueDate(date);
      }
    }
  }

  Future saveRepeat(TaskRepeat repeat) async {
    await editWrapper(() async {
      setLoaderScreenSaving();
      if (await task.ws.checkBalance(loc.edit_action_title)) {
        final etr = await taskRepeatsUC.save(repeat);
        if (etr != null) {
          task.repeat = etr;
        }
      }
    });
  }

  Future deleteRepeat() async {
    if (task.repeat != null) {
      await editWrapper(() async {
        setLoaderScreenSaving();
        if (await task.ws.checkBalance(loc.edit_action_title)) {
          final deletedRepeat = await taskRepeatsUC.delete(task.repeat!);
          if (deletedRepeat != null) {
            task.repeat = null;
          }
        }
      });
    }
  }
}
