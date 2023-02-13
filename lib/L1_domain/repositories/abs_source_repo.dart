// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import 'abs_ws_repo.dart';

abstract class AbstractSourceRepo extends AbstractWSRepo<Source> {
  Future<bool> checkConnection(Source s);
}
