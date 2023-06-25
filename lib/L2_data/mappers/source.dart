// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';

extension SourceMapper on SourceGet {
  Source source(int wsId) => Source(
        id: id,
        type: SourceType(title: type, code: type),
        url: url,
        apiKey: apiKey,
        username: username,
        description: description ?? '',
        wsId: wsId,
      );
}
