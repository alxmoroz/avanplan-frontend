// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/note.dart';
import '../../../../L1_domain/utils/dates.dart';
import 'task_controller.dart';

part 'notes_controller.g.dart';

class NotesController extends _NotesControllerBase with _$NotesController {
  NotesController(TaskController tcIn) {
    _tc = tcIn;
  }
}

abstract class _NotesControllerBase with Store {
  late final TaskController _tc;

  @observable
  ObservableList<Note> _notes = ObservableList();

  @action
  void reload() {
    _notes = ObservableList.of(_tc.task.notes.map((n) {
      n.attachments = _tc.attachmentsController.sortedAttachments.where((a) => a.noteId == n.id).toList();
      return n;
    }));
  }

  @observable
  Note? currentNote;

  @action
  void setCurrentNote(Note? note) => currentNote = note;

  @computed
  List<Note> get _sortedNotes => _notes.sorted((n1, n2) => n1.compareTo(n2));
  @computed
  Map<DateTime, List<Note>> get notesGroups => _sortedNotes.groupListsBy((n) => n.createdOn!.date);
  @computed
  List<DateTime> get sortedNotesDates => notesGroups.keys.sorted((d1, d2) => d2.compareTo(d1));
  @computed
  bool get hasNotes => _notes.isNotEmpty;
}
