// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/system/errors.dart';
import '../extra/services.dart';

extension TaskSaving on Task {
  Future<Task?> save() async {
    loading = true;
    mainController.refresh();
    Task? et;
    try {
      et = await taskUC.save(ws, this);
      if (et != null) {
        // вложенности
        if (et.tasks.isEmpty) {
          et.tasks = tasks;
        }
        if (et.members.isEmpty) {
          et.members = members;
        }
        if (et.projectStatuses.isEmpty) {
          et.projectStatuses = projectStatuses;
        }
        if (et.notes.isEmpty) {
          et.notes = notes;
        }

        // структура
        if (parent != null) {
          if (isNew) {
            parent!.tasks.add(et);
          } else {
            final index = parent!.tasks.indexWhere((t) => et?.ws.id == t.ws.id && et?.id == t.id);
            if (index > -1) {
              parent!.tasks[index] = et;
            }
          }
        }
        if (isNew) {
          mainController.allTasks.add(et);
        } else {
          mainController.setTask(et);
        }
      }
    } catch (e) {
      error = MTError(loader.titleText ?? '', detail: loader.descriptionText);
    }
    loading = false;
    mainController.refresh();
    return et;
  }
}
