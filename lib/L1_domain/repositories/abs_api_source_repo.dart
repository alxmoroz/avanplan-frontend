// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../repositories/abs_api_repo.dart';

abstract class AbstractApiSourceRepo extends AbstractApiRepo<Source> {
  Future<bool> checkConnection(int id);
}
