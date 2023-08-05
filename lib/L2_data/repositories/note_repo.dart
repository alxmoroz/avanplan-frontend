// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/note.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/repositories/abs_ws_repo.dart';
import '../mappers/note.dart';
import '../services/api.dart';

class NoteRepo extends AbstractWSRepo<Note> {
  o_api.TasksNotesApi get api => openAPI.getTasksNotesApi();

  @override
  Future<Note?> save(Workspace ws, Note data) async {
    final b = o_api.NoteUpsertBuilder()
      ..id = data.id
      ..authorId = data.authorId
      ..taskId = data.taskId
      ..parentId = data.parent?.id
      ..text = data.text
      ..type = data.type;

    final response = await api.upsertV1TasksNotesPost(
      noteUpsert: b.build(),
      wsId: ws.id!,
    );

    final resData = response.data;
    if (resData != null) {
      if (data.id == null) {
        data = resData.note;
      }
      return data;
    } else {
      return null;
    }
  }

  @override
  Future<bool> delete(Workspace ws, Note data) async {
    final response = await api.deleteV1TasksNotesNoteIdDelete(
      noteId: data.id!,
      wsId: ws.id!,
    );
    return response.data == true;
  }
}
