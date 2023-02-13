// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/base_entity.dart';

extension PersonPresenter on Person {
  String get rolesStr => roles.map((r) => Intl.message('role_code_${r.toLowerCase()}')).join(', ');
}
