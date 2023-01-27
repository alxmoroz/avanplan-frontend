// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/status.dart';

extension StatusMapper on api.StatusGet {
  Status get status => Status(
        id: id,
        code: code,
        closed: closed,
      );
}
