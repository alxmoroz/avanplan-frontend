// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';
import '../presenters/number.dart';
import '../views/iap/iap_dialog.dart';
import '../views/tariff/tariff_selector.dart';

extension WSTariffUC on Workspace {
  Future changeTariff({String reason = ''}) async {
    final tariff = await selectTariff(id!, reason: reason);
    if (tariff != null) {
      loader.setSaving();
      loader.start();
      final signedInvoice = await contractUC.sign(tariff.id!, id!);
      if (signedInvoice != null) {
        invoice = signedInvoice;
        await wsMainController.reloadWS(id!);
      }
      loader.stop();
    }
  }

  Future<bool> checkBalance(String operation, {num extraMoney = 0}) async {
    final lack = extraMoney - balance;
    if (lack > 0) {
      final hasSelectPay = await replenishBalanceDialog(
        id!,
        reason: loc.error_insufficient_funds_for_operation(
          '${lack.ceil().currency}₽',
          operation.toLowerCase(),
        ),
      );
      if (hasSelectPay == true) {
        await mainController.reload();
      }
    }
    return lack <= 0;
  }

  // Future showTariffExcessInfo() async {
  //   if (!accountController.tariffExcessInfoViewed(id!)) {
  //     final needChangeTariff = await showMTAlertDialog(
  //       loc.limits_exceed_info_dialog_title,
  //       description: loc.limits_exceed_info_dialog_description,
  //       actions: [
  //         MTADialogAction(title: loc.tariff_list_title, type: MTActionType.isDefault, result: true),
  //         MTADialogAction(title: loc.ok, result: false),
  //       ],
  //       simple: true,
  //     );
  //     accountController.setlLimitsExceedInfoViewed(id!);
  //     if (needChangeTariff == true) {
  //       await changeTariff();
  //     }
  //   }
  // }
}
