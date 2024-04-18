// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/attachment.dart';
import '../../../../L1_domain/entities/note.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../extra/services.dart';
import '../../../usecases/note_edit.dart';
import '../widgets/text_fields/text_edit_dialog.dart';
import 'attachments_controller.dart';
import 'task_controller.dart';

part 'notes_controller.g.dart';

class NotesController extends _NotesControllerBase with _$NotesController {
  NotesController(TaskController taskController) {
    _taskController = taskController;
    reload();
  }
}

abstract class _NotesControllerBase with Store {
  late final TaskController _taskController;

  Task get task => _taskController.task!;
  final _fNoteIndex = TaskFCode.note.index;
  TextEditingController get _te => _taskController.teController(_fNoteIndex)!;
  AttachmentsController get _attachmentsController => _taskController.attachmentsController;

  final notesWidgetGlobalKey = GlobalKey();

  /// вложения

  Future _uploadAttachments(Note note) async {
    if (_attachmentsController.selectedFiles.isNotEmpty) {
      for (final f in _attachmentsController.selectedFiles) {
        final attachment = await attachmentUC.upload(
          task.wsId,
          task.id!,
          note.id!,
          f.openRead,
          await f.length(),
          f.name,
          await f.lastModified(),
        );
        if (attachment != null) {
          task.attachments.add(attachment);
        }
      }
      _attachmentsController.setFiles([]);
      _attachmentsController.reload();
    }
  }

  Future startUpload({bool instant = true}) async {
    await _attachmentsController.selectFiles();
    if (instant && _attachmentsController.selectedFiles.isNotEmpty) {
      await _save(Note(
        text: '',
        taskId: task.id!,
        wsId: task.wsId,
      ));
    }
  }

  Future downloadAttachment(Attachment attachment) async => await _attachmentsController.download(attachment);

  /// комменты

  @observable
  ObservableList<Note> _notes = ObservableList();

  @action
  void reload() {
    _notes = ObservableList.of(task.notes.map((n) {
      n.attachments = _attachmentsController.sortedAttachments.where((a) => a.noteId == n.id).toList();
      return n;
    }));
  }

  @computed
  List<Note> get _sortedNotes => _notes.sorted((n1, n2) => n2.createdOn!.compareTo(n1.createdOn!));
  @computed
  Map<DateTime, List<Note>> get notesGroups => _sortedNotes.groupListsBy((n) => n.createdOn!.date);
  @computed
  List<DateTime> get sortedNotesDates => notesGroups.keys.sorted((d1, d2) => d2.compareTo(d1));

  Future _save(Note note) async {
    final newValue = _te.text.trim();
    final oldValue = note.text;
    if (note.text != newValue || note.isNew) {
      _taskController.updateField(_fNoteIndex, loading: true, text: '');
      note.text = newValue;
      final en = await note.save(task);
      if (en == null) {
        note.text = oldValue;
      } else {
        // если есть вложения
        await _uploadAttachments(en);
      }

      reload();
      _taskController.updateField(_fNoteIndex, loading: false);

      if (notesWidgetGlobalKey.currentContext?.mounted == true) {
        Scrollable.ensureVisible(notesWidgetGlobalKey.currentContext!);
      }
    }
  }

  Future edit(Note note) async {
    _te.text = note.text;
    if (await showMTDialog<bool?>(
            TextEditDialog(
              _taskController,
              TaskFCode.note,
              loc.task_note_title,
              note: note,
            ),
            maxWidth: SCR_M_WIDTH) ==
        true) {
      // добавление или редактирование
      await _save(note);
      _te.text = '';
    } else if (!note.isNew) {
      _te.text = '';
    }
  }

  Future create() async {
    await edit(Note(
      text: _te.text,
      taskId: task.id!,
      wsId: task.wsId,
    ));
  }

  Future delete(Note note) async {
    await note.delete(task);
    _attachmentsController.reload();
    reload();
  }
}
