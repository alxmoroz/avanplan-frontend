// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/role.dart';

String localizedRoleCode(String code) => Intl.message('role_code_${code.toLowerCase()}');

extension RolePresenter on Role {
  String get localize => localizedRoleCode(code);
}
