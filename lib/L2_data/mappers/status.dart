// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/status.dart';

extension StatusMapper on StatusGet {
  Status status(int wsId) => Status(
        id: id,
        code: code,
        closed: closed,
        wsId: wsId,
      );
}
