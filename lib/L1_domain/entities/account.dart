// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class AccountOperation extends RPersistable {
  AccountOperation({
    required super.id,
    required this.createdOn,
    required this.amount,
    required this.basis,
  });

  final DateTime? createdOn;
  final num amount;
  final String basis;
}

class Account extends WSBounded {
  Account({
    required super.id,
    required super.wsId,
    required this.incomingOperations,
  });

  final Iterable<AccountOperation> incomingOperations;
}
