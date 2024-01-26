// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';
import '../presenters/number.dart';
import '../views/iap/iap_dialog.dart';
import '../views/tariff/tariff_selector.dart';
import '../views/tariff/tariff_selector_controller.dart';

extension WSTariffUC on Workspace {
  // TODO: сменить на checkLimits по аналогии с checkBalance
  Future changeTariff({String reason = ''}) async {
    final tsController = TariffSelectorController(id!, reason);
    tsController.getData();
    final tariff = await selectTariff(tsController);
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
}
