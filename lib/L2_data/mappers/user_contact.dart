// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/user_contact.dart';

extension UserContactMapper on api.UserContactGet {
  UserContact get userContact => UserContact(
        id: id,
        userId: userId,
        value: value,
        description: description ?? '',
      );
}
