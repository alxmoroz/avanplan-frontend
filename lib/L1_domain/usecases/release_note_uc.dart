// Copyright (c) 2024. Alexandr Moroz

import '../entities/release_note.dart';
import '../repositories/abs_release_note_repo.dart';

class ReleaseNoteUC {
  ReleaseNoteUC(this.repo);

  final AbstractReleaseNoteRepo repo;

  Future<Iterable<ReleaseNote>> getReleaseNotes(String oldVersion) async => await repo.getReleaseNotes(oldVersion);
}
