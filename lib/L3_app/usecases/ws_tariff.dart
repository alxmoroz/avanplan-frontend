// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/workspace.dart';
import '../components/alert_dialog.dart';
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
      final signedContractInvoice = await contractUC.sign(tariff.id!, id!);
      if (signedContractInvoice != null) {
        invoice = signedContractInvoice;
        await wsMainController.reloadWS(id!);
      }
      await loader.stop();
    }
  }

  Future<bool> checkBalance(String operation, {num extraMoney = 0}) async {
    final lack = balanceLack + extraMoney;
    if (lack > 0) {
      final hasSelectPay = await replenishBalanceDialog(
        id!,
        reason: loc.error_insufficient_funds_for_operation(
          '${lack.ceil().currency} ₽',
          operation.toLowerCase(),
        ),
      );
      if (hasSelectPay == true) {
        await mainController.manualUpdate();
      }
    }
    return lack <= 0;
  }

  Future showTariffExcessInfo() async {
    if (!accountController.tariffExcessInfoViewed(id!)) {
      final needChangeTariff = await showMTAlertDialog(
        loc.limits_exceed_info_dialog_title,
        description: loc.limits_exceed_info_dialog_description,
        actions: [
          MTADialogAction(title: loc.tariff_list_title, type: MTActionType.isDefault, result: true),
          MTADialogAction(title: loc.ok, result: false),
        ],
        simple: true,
      );
      accountController.setlLimitsExceedInfoViewed(id!);
      if (needChangeTariff == true) {
        await changeTariff();
      }
    }
  }
}
