// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/person.dart';
import '../../L1_domain/entities/role.dart';

extension PersonPresenter on Person {
  String get rolesTitles => roles.map((rCode) => Role(code: rCode, id: null).title).join(', ');
  String get rolesDescriptions => roles.map((rCode) => Role(code: rCode, id: null).description).join(', ');

  String get initials {
    final words = viewableName.split(RegExp(r'\s'));
    return words.map((w) => w.substring(0, 1).toUpperCase()).join('');
  }
}
