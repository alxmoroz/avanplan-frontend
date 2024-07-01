// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/role.dart';

extension PersonPresenter on Person {
  String get rolesStr => roles.map((rCode) => Role(code: rCode, id: null).title).join(', ');
}
