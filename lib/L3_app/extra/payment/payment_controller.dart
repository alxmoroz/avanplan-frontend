// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_button.dart';
import '../../components/text_widgets.dart';
import '../services.dart';

part 'payment_controller.g.dart';

class PaymentController = _PaymentControllerBase with _$PaymentController;

abstract class _PaymentControllerBase with Store {
  @observable
  bool waitingPayment = false;

  @action
  void resetWaiting() => waitingPayment = false;

  @action
  Future ymQuickPayForm(int wsId, num amount) async {
    final userId = accountController.user?.id;
    if (userId != null) {
      await paymentUC.ymQuickPayForm(amount, wsId, userId);
      waitingPayment = true;
    }
  }

  Widget ymPayButton(int wsId, int amount) => MTButton.outlined(
        titleColor: greenColor,
        middle: Row(children: [
          MediumText(' + $amount', color: greenColor),
          const RoubleIcon(size: P * 1.6, color: greenColor),
        ]),
        onTap: () => ymQuickPayForm(wsId, amount),
        constrained: false,
        padding: const EdgeInsets.symmetric(horizontal: P_2),
      );
}
