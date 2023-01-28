// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/person.dart';

extension PersonMapper on api.PersonGet {
  Person person(int wsId) => Person(
        id: id,
        email: email,
        firstname: firstname,
        lastname: lastname,
        workspaceId: wsId,
      );
}
