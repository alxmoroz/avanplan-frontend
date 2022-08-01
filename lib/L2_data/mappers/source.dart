// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';
import 'source_type.dart';

extension SourceMapper on SourceGet {
  Source get source => Source(
        id: id,
        type: type.type,
        url: url,
        apiKey: apiKey,
        login: login,
        description: description,
        workspaceId: workspaceId,
      );
}
