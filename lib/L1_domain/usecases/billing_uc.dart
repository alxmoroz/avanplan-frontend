// Copyright (c) 2022. Alexandr Moroz

import '../repositories/abs_billing_repo.dart';

class BillingUC {
  BillingUC({required this.repo});

  final AbstractBillingRepo repo;

  Future<bool> ymQuickPayForm(num amount, int wsId) async => await repo.ymQuickPayForm(amount, wsId);
}
