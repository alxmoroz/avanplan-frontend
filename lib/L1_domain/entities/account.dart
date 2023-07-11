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

class Account extends RPersistable {
  Account({
    required super.id,
    required this.incomingOperations,
  });

  static Account get dummy => Account(id: null, incomingOperations: []);

  final Iterable<AccountOperation> incomingOperations;
}
