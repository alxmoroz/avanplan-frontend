// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/role.dart';

extension RoleMapper on api.RoleGet {
  Role role(int wsId) => Role(
        id: id,
        code: code,
        wsId: wsId,
      );
}
