// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/release_note.dart';

extension ReleaseNoteMapper on ReleaseNoteGet {
  ReleaseNote get releaseNote => ReleaseNote(
        id: id,
        title: title,
        description: description ?? '',
        version: version,
      );
}
