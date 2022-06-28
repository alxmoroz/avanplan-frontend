// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class LocalAuth extends LocalPersistable {
  LocalAuth({
    this.accessToken = '',
  }) : super(id: 'local_auth');

  String accessToken;
}
