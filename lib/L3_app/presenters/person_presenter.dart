// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/base_entity.dart';
import 'role_presenter.dart';

extension PersonPresenter on Person {
  String get rolesStr => roles.map((rCode) => localizedRoleCode(rCode)).join(', ');
}
