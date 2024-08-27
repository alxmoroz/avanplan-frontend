// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/role.dart';

extension PersonPresenter on Person {
  String get rolesTitles => roles.map((rCode) => Role(code: rCode, id: null).title).join(', ');
  String get rolesDescriptions => roles.map((rCode) => Role(code: rCode, id: null).description).join(', ');
}
