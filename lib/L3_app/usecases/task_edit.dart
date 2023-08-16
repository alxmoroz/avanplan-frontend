// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/system/errors.dart';
import '../../L2_data/services/api.dart';
import '../../main.dart';
import '../extra/services.dart';

extension TaskSaving on Task {
  Future<Task?> _edit(Future<Task?> function()) async {
    loading = true;
    mainController.refresh();
    Task? et;
    try {
      et = await function();
    } on DioException catch (e) {
      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    mainController.refresh();

    return et;
  }

  Task _update(Task? et) {
    if (et != null) {
      // вложенности
      if (et.members.isEmpty) {
        et.members = members;
      }
      if (et.projectStatuses.isEmpty) {
        et.projectStatuses = projectStatuses;
      }
      if (et.notes.isEmpty) {
        et.notes = notes;
      }
      if (isNew) {
        mainController.addTasks([et]);
      } else {
        mainController.setTask(et);
      }
      return et;
    }
    return this;
  }

  Future<Task?> save() async => await _edit(() async {
        final et = await taskUC.save(this);
        return _update(et);
      });

  Future delete() async => await _edit(() async {
        Navigator.of(rootKey.currentContext!).pop();
        if (await taskUC.delete(this)) {
          mainController.removeTask(this);
        }
        return null;
      });
}
