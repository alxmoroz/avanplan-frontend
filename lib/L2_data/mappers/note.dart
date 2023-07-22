// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/note.dart';

extension NoteMapper on NoteGet {
  Note get note => Note(
        id: id,
        text: text,
        authorId: authorId,
        taskId: taskId,
        type: type,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
      );
}
