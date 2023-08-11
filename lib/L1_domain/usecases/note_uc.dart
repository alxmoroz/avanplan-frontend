// Copyright (c) 2022. Alexandr Moroz

import '../entities/note.dart';
import '../entities/workspace.dart';
import '../repositories/abs_ws_repo.dart';

//TODO: похоже, есть смысл сделать абстрактный общий юзкейс

class NoteUC {
  NoteUC(this.repo);

  final AbstractWSRepo<Note> repo;

  Future<Note?> save(Workspace ws, Note n) async => await repo.save(ws, n);
  Future<bool> delete(Workspace ws, Note n) async => await repo.delete(ws, n);
}
