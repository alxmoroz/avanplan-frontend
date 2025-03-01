// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as api;

import '../../L1_domain/entities/role.dart';

extension RoleMapper on api.RoleGet {
  Role get role => Role(
        id: id,
        code: code,
      );
}
