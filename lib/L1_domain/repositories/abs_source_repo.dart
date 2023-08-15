// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/source_type.dart';
import 'abs_api_repo.dart';

abstract class AbstractSourceRepo extends AbstractApiRepo<Source> {
  Future<bool> checkConnection(Source s);
  Future<bool> requestSourceType(SourceType st);
}
