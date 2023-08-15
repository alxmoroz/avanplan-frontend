// Copyright (c) 2022. Alexandr Moroz

import '../entities/note.dart';
import '../repositories/abs_api_repo.dart';

class NoteUC {
  NoteUC(this.repo);

  final AbstractApiRepo<Note> repo;

  Future<Note?> save(Note n) async => await repo.save(n);
  Future<bool> delete(Note n) async => await repo.delete(n);
}
