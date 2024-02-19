// Copyright (c) 2024. Alexandr Moroz

import '../entities/release_note.dart';
import 'abs_api_repo.dart';

abstract class AbstractReleaseNoteRepo extends AbstractApiRepo<ReleaseNote, ReleaseNote> {
  Future<Iterable<ReleaseNote>> getReleaseNotes(String oldVersion);
}
