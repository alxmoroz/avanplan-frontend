// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/status.dart';

extension StatusMapper on StatusGet {
  Status get status => Status(
        id: id,
        code: code,
        closed: closed,
      );
}
