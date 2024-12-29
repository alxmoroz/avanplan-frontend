// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/note.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../../app/services.dart';
import '../controllers/task_controller.dart';
import '../usecases/attachments.dart';

final _fNoteIndex = TaskFCode.note.index;

extension NoteEditUC on TaskController {
  TextEditingController get _te => teController(_fNoteIndex)!;

  Future _noteEditWrapper(Note note, Function() function) async {
    note.loading = true;

    tasksMainController.refreshUI();

    setLoaderScreenSaving();
    await load(function);

    note.loading = false;
    tasksMainController.refreshUI();
  }

  Future saveNote(Note note) async {
    final newValue = _te.text.trim();
    _te.text = '';
    final oldValue = note.text;
    if (note.text != newValue || note.isNew) {
      updateField(_fNoteIndex, loading: true, text: '');
      note.text = newValue;
      Note? en;
      await _noteEditWrapper(note, () async {
        if (await task.ws.checkBalance(loc.task_note_add_action_title)) {
          en = await notesUC.save(note);
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

            if (note.isNew) {
              task.notes.add(en!);
            } else {
              final index = task.notes.indexWhere((n) => en!.taskId == task.id && en!.id == n.id);
              if (index > -1) {
                task.notes[index] = en!;
              }
            }
          }
        }
      });

      if (en != null) {
        // если есть вложения
        await attachmentsController.uploadAttachments(en!);
      } else {
        note.text = oldValue;
      }

      notesController.reload();
      updateField(_fNoteIndex, loading: false);

      if (notesWidgetGlobalKey.currentContext?.mounted == true) {
        Scrollable.ensureVisible(notesWidgetGlobalKey.currentContext!);
      }
    }
    notesController.setCurrentNote(null);
  }

  Future editNote(Note note) async {
    _te.text = note.text;
    notesController.setCurrentNote(note);
  }

  void resetNoteEdit() {
    _te.text = '';
    notesController.setCurrentNote(null);
  }

  Future createNote() async {
    final newNote = Note(
      text: _te.text,
      taskId: task.id!,
      wsId: task.wsId,
    );
    await saveNote(newNote);
  }

  Future deleteNote(Note note) async {
    await _noteEditWrapper(note, () async {
      final deletedNote = await notesUC.delete(note);
      if (deletedNote != null) {
        task.notes.remove(note);
        final noteAttachmentsIds = note.attachments.map((na) => na.id);
        task.attachments.removeWhere((ta) => noteAttachmentsIds.contains(ta.id));
      }
    });

    attachmentsController.reload();
    notesController.reload();
  }
}
