// Copyright (c) 2024. Alexandr Moroz

import '../entities/release_note.dart';

abstract class AbstractReleaseNotesRepo {
  Future<Iterable<ReleaseNote>> getReleaseNotes(String oldVersion);
}
