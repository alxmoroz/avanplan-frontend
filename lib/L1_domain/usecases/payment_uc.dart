// Copyright (c) 2022. Alexandr Moroz

import '../repositories/abs_payment_repo.dart';

class PaymentUC {
  PaymentUC(this.repo);
  Future<PaymentUC> init() async => this;

  final AbstractPaymentRepo repo;

  Future<bool> ymQuickPayForm(num amount, int wsId, int userId) async => await repo.ymQuickPayForm(amount, wsId, userId);
}
