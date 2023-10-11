// Copyright (c) 2022. Alexandr Moroz

import '../entities/workspace.dart';
import 'abs_api_repo.dart';

abstract class AbstractWSRepo extends AbstractApiRepo<Workspace, WorkspaceUpsert> {
  Future<Workspace?> getOne(int wsId);
  Future<Workspace?> create({WorkspaceUpsert? ws});
}
