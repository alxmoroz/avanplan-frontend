// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/entities/note.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/system/errors.dart';
import '../../L2_data/services/api.dart';
import '../extra/services.dart';

extension NoteSaving on Note {
  Future<Note?> _edit(Task task, Future<Note?> function()) async {
    loading = true;
    mainController.refresh();
    Note? en;
    try {
      en = await function();
    } on DioException catch (e) {
      task.error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    mainController.refresh();

    return en;
  }

  Future<Note?> save(Task task) async => await _edit(task, () async {
        final en = await noteUC.save(task.ws, this);
        if (en != null) {
          // TODO: вложенности
          // if (en.notes.isEmpty) {
          //   en.notes = notes;
          // }

          // TODO:  структура
          // if (parent != null) {
          //   if (isNew) {
          //     parent!.notes.add(en);
          //   } else {
          //     final index = parent!.notes.indexWhere((n) => en?.taskId == task.id && en?.id == n.id);
          //     if (index > -1) {
          //       parent!.notes[index] = en;
          //     }
          //   }
          // }

          if (isNew) {
            task.notes.add(en);
          } else {
            final index = task.notes.indexWhere((n) => en.taskId == task.id && en.id == n.id);
            if (index > -1) {
              task.notes[index] = en;
            }
          }
        }
        return en;
      });

  Future delete(Task task) async => await _edit(task, () async {
        if (await noteUC.delete(task.ws, this)) {
          task.notes.remove(this);
        }
        return null;
      });
}
