// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/note.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../extra/services.dart';
import '../../../usecases/note_edit.dart';
import '../../../usecases/task_actions.dart';
import '../widgets/text_fields/text_edit_dialog.dart';
import 'task_controller.dart';

part 'notes_controller.g.dart';

class NotesController extends _NotesControllerBase with _$NotesController {
  NotesController(TaskController taskController) {
    _taskController = taskController;
    _setNotes(taskController.task!.notes);
  }
}

abstract class _NotesControllerBase with Store {
  late final TaskController _taskController;

  Task get task => _taskController.task!;
  final _fNoteIndex = TaskFCode.note.index;
  TextEditingController get _te => _taskController.teController(_fNoteIndex)!;

  final notesWidgetGlobalKey = GlobalKey();

  @observable
  ObservableList<Note> _notes = ObservableList();

  @action
  void _setNotes(Iterable<Note> notes) => _notes = ObservableList.of(notes);
  void _refresh() => _setNotes(task.notes);

  @computed
  List<Note> get _sortedNotes => _notes.sorted((n1, n2) => n2.createdOn!.compareTo(n1.createdOn!));
  @computed
  Map<DateTime, List<Note>> get notesGroups => _sortedNotes.groupListsBy((n) => n.createdOn!.date);
  @computed
  List<DateTime> get sortedNotesDates => notesGroups.keys.sorted((d1, d2) => d2.compareTo(d1));

  Future _save(Note note) async {
    final newValue = _te.text;
    final oldValue = note.text;
    if (newValue.trim().isNotEmpty && (note.text != newValue || note.isNew)) {
      _taskController.updateField(_fNoteIndex, loading: true, text: '');
      note.text = newValue;
      final en = await note.save(task);
      if (en == null) {
        note.text = oldValue;
      } else {
        // TODO: это можно сделать на бэке — прописать айдишник коммента вложению после сохранения вложения и коммента
        if (_taskController.attachmentsController.selectedFiles.isNotEmpty) {
          for (final f in _taskController.attachmentsController.selectedFiles) {
            await attachmentUC.upload(task.wsId, task.id!, en.id!, f.openRead, await f.length(), f.name, await f.lastModified());
          }
        }
      }

      _refresh();
      _taskController.updateField(_fNoteIndex, loading: false);
    }
  }

  Future edit(Note note) async {
    _te.text = note.text;
    if (await showMTDialog<bool?>(TextEditDialog(_taskController, TaskFCode.note, loc.task_note_title), maxWidth: SCR_M_WIDTH) == true) {
      // добавление или редактирование
      await _save(note);
      _te.text = '';
    } else if (!note.isNew) {
      _te.text = '';
    }
    if (notesWidgetGlobalKey.currentContext?.mounted == true) {
      Scrollable.ensureVisible(notesWidgetGlobalKey.currentContext!);
    }
  }

  Future create() async {
    await edit(Note(
      text: _te.text,
      authorId: task.me?.id,
      taskId: task.id!,
      wsId: task.wsId,
    ));
  }

  Future delete(Note note) async {
    await note.delete(task);
    _refresh();
  }
}
