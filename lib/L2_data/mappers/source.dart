// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/source.dart';

extension SourceMapper on SourceGet {
  Source source(int wsId) => Source(
        id: id,
        type: type,
        url: url,
        apiKey: apiKey,
        username: username,
        description: description ?? '',
        workspaceId: wsId,
      );
}
