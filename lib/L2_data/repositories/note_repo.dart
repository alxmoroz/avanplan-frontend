// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/note.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/note.dart';
import '../services/api.dart';

class NoteRepo extends AbstractApiRepo<Note, Note> {
  o_api.TaskNotesApi get api => openAPI.getTaskNotesApi();

  @override
  Future<Note?> save(Note data) async {
    final b = o_api.NoteUpsertBuilder()
      ..id = data.id
      ..createdOn = data.createdOn?.toUtc()
      ..authorId = data.authorId
      ..taskId = data.taskId
      ..parentId = data.parent?.id
      ..text = data.text
      ..type = data.type;

    final response = await api.upsertNote(
      noteUpsert: b.build(),
      taskId: data.taskId,
      wsId: data.wsId,
    );

    final resData = response.data;
    if (resData != null) {
      if (data.id == null) {
        data = resData.note(data.wsId);
      }
      return data;
    } else {
      return null;
    }
  }

  @override
  Future<Note?> delete(Note data) async {
    final response = await api.deleteNote(
      noteId: data.id!,
      taskId: data.taskId,
      wsId: data.wsId,
    );
    return response.data == true ? data : null;
  }
}
