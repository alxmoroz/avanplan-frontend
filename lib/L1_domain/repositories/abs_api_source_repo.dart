// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import 'abs_api_ws_repo.dart';

abstract class AbstractApiSourceRepo extends AbstractApiWSRepo<Source> {
  Future<bool> checkConnection(Source s);
}
