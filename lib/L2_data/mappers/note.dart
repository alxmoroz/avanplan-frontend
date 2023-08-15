// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/note.dart';
import '../../L1_domain/entities/workspace.dart';

extension NoteMapper on NoteGet {
  Note note(Workspace ws) => Note(
        id: id,
        text: text,
        authorId: authorId,
        taskId: taskId,
        type: type,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
        ws: ws,
      );
}
