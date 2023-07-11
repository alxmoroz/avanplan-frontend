// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/source_type.dart';
import '../entities/workspace.dart';
import 'abs_ws_repo.dart';

abstract class AbstractSourceRepo extends AbstractWSRepo<Source> {
  Future<bool> checkConnection(Workspace ws, Source s);
  Future<bool> requestSourceType(SourceType st);
}
