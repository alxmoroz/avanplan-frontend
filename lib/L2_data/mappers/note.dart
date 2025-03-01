// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';

import '../../L1_domain/entities/note.dart';

extension NoteMapper on NoteGet {
  Note note(int wsId) => Note(
        id: id,
        text: text,
        authorId: authorId,
        taskId: taskId,
        type: type,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
        wsId: wsId,
      );
}
