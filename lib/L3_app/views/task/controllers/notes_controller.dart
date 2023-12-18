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
  NotesController(TaskController _taskController) {
    taskController = _taskController;
    _setNotes(_taskController.task!.notes);
  }
}

abstract class _NotesControllerBase with Store {
  late final TaskController taskController;

  Task get task => taskController.task!;
  final _fIndex = TaskFCode.note.index;
  TextEditingController get _te => taskController.teController(_fIndex)!;

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
      taskController.updateField(_fIndex, loading: true, text: '');
      note.text = newValue;

      if (await note.save(task) == null) {
        note.text = oldValue;
      }

      _refresh();
      taskController.updateField(_fIndex, loading: false);
    }
  }

  Future edit(Note note) async {
    _te.text = note.text;
    if (await showMTDialog<bool?>(TextEditDialog(taskController, TaskFCode.note, loc.task_note_title), maxWidth: SCR_M_WIDTH) == true) {
      // добавление или редактирование
      await _save(note);
    }
    _te.text = '';
  }

  Future create() async {
    await _save(
      Note(
        text: _te.text,
        authorId: task.me?.id,
        taskId: task.id!,
        wsId: task.wsId,
      ),
    );
    _te.text = '';
    Scrollable.ensureVisible(notesWidgetGlobalKey.currentContext!);
  }

  Future delete(Note note) async {
    await note.delete(task);
    _refresh();
  }
}
