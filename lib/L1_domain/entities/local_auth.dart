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

  static const _authCheckPeriod = Duration(hours: 12);
  bool get needRefresh => signinDate == null || signinDate!.add(_authCheckPeriod).isBefore(DateTime.now());
  bool get hasToken => accessToken.isNotEmpty;
}
