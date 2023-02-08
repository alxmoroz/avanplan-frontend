// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/user.dart';

extension UserPresenter on User {
  String get rolesStr => roles.map((r) => Intl.message('role_${r.toLowerCase()}')).join(', ');
}
