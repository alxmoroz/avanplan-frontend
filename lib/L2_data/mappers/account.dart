// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/account.dart';

extension AccountOperationMapper on api.AccountOperationGet {
  AccountOperation get accountOperation => AccountOperation(
        id: id,
        createdOn: createdOn.toLocal(),
        amount: amount,
        basis: basis,
      );
}

extension AccountMapper on api.AccountGet {
  Account account(int wsId) => Account(
        id: id,
        wsId: wsId,
        incomingOperations: incomingOperations.map((op) => op.accountOperation),
      );
}
