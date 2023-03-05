// Copyright (c) 2023. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../services.dart';

part 'payment_controller.g.dart';

class PaymentController = _PaymentControllerBase with _$PaymentController;

abstract class _PaymentControllerBase with Store {
  @observable
  bool waitingPayment = false;

  @action
  void resetWaiting() => waitingPayment = false;

  @action
  Future ymQuickPayForm(num amount, int wsId) async {
    await billingUC.ymQuickPayForm(amount, wsId);
    waitingPayment = true;
  }
}
