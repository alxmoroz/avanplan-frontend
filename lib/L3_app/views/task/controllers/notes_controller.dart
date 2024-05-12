// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/note.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../views/_base/loadable.dart';
import 'task_controller.dart';

part 'notes_controller.g.dart';

class NotesController extends _NotesControllerBase with _$NotesController {
  NotesController(TaskController taskControllerIn) {
    taskController = taskControllerIn;
  }
}

abstract class _NotesControllerBase with Store, Loadable {
  late final TaskController taskController;

  /// комменты

  @observable
  ObservableList<Note> _notes = ObservableList();

  @action
  void reload() {
    _notes = ObservableList.of(taskController.task.notes.map((n) {
      n.attachments = taskController.attachmentsController.sortedAttachments.where((a) => a.noteId == n.id).toList();
      return n;
    }));
  }

  @computed
  List<Note> get _sortedNotes => _notes.sorted((n1, n2) => n2.createdOn!.compareTo(n1.createdOn!));
  @computed
  Map<DateTime, List<Note>> get notesGroups => _sortedNotes.groupListsBy((n) => n.createdOn!.date);
  @computed
  List<DateTime> get sortedNotesDates => notesGroups.keys.sorted((d1, d2) => d2.compareTo(d1));
}
