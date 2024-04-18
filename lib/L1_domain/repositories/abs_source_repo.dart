// Copyright (c) 2022. Alexandr Moroz

import '../entities/source.dart';
import '../entities/source_type.dart';
import 'abs_api_repo.dart';

abstract class AbstractSourceRepo extends AbstractApiRepo<Source, Source> {
  Future<bool> checkConnection(Source s) async => throw UnimplementedError();
  Future<bool> requestType(SourceType st, int wsId) async => throw UnimplementedError();
}
