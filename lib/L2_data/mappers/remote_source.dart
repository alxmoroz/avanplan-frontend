// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart';

import '../../L1_domain/entities/remote_source.dart';

extension RemoteSourceMapper on SourceGet {
  RemoteSource source(int wsId) => RemoteSource(
        id: id,
        typeCode: type,
        url: url,
        apiKey: apiKey,
        username: username,
        description: description ?? '',
        wsId: wsId,
      );
}
