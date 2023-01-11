// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class LocalAuth extends LocalPersistable {
  LocalAuth({
    super.id = 'local_auth',
    this.accessToken = '',
    this.signinDate,
  });

  String accessToken;
  DateTime? signinDate;
}
