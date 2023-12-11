// Copyright (c) 2023. Alexandr Moroz

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/entities/workspace.dart';
import '../components/constants.dart';
import '../components/dialog.dart';
import '../extra/services.dart';
import '../views/tariff/tariff_selector.dart';
import '../views/tariff/tariff_selector_controller.dart';

extension WSTariffUC on Workspace {
  Future changeTariff({String reason = ''}) async {
    final tsController = TariffSelectorController(id!, reason);
    tsController.getData();
    final tariff = await showMTDialog<Tariff?>(TariffSelector(tsController), maxWidth: SCR_XL_WIDTH);
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
}
