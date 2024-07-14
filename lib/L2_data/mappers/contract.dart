// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/contract.dart';

extension ContractMapper on o_api.ContractGet {
  Contract get contract => Contract(
        id: id,
        createdOn: createdOn.toLocal(),
      );
}
