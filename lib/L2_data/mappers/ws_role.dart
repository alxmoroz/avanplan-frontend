// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/ws_role.dart';

extension WSRoleMapper on WRoleGet {
  WSRole get wsRole => WSRole(
        id: id,
        code: code.toLowerCase(),
      );
}
