// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/contract.dart';

extension ContractMapper on api.ContractGet {
  Contract get contract => Contract(
        id: id,
        createdOn: createdOn.toLocal(),
        expiresOn: expiresOn?.toLocal(),
      );
}
