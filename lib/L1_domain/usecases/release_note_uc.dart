// Copyright (c) 2024. Alexandr Moroz

import '../entities/release_note.dart';
import '../repositories/abs_release_notes_repo.dart';

class ReleaseNotesUC {
  ReleaseNotesUC(this.repo);

  final AbstractReleaseNotesRepo repo;

  Future<Iterable<ReleaseNote>> getReleaseNotes(String oldVersion) async => await repo.getReleaseNotes(oldVersion);
}
