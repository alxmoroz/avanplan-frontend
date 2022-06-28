// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/person.dart';

extension PersonMapper on PersonSchemaGet {
  Person get person => Person(
        id: id,
        workspaceId: workspaceId,
        email: email,
        firstname: firstname,
        lastname: lastname,
      );
}
