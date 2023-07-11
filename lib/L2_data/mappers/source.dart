// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';

extension SourceMapper on SourceGet {
  Source get source => Source(
        id: id,
        typeCode: type,
        url: url,
        apiKey: apiKey,
        username: username,
        description: description ?? '',
      );
}
