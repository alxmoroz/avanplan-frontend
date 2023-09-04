// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/entities/workspace.dart';
import '../components/dialog.dart';
import '../extra/services.dart';
import '../views/tariff/tariff_select_view.dart';

extension WSTariffUC on Workspace {
  Future changeTariff({String reason = ''}) async {
    loader.start();
    loader.setLoading();
    final tariffs = (await tariffUC.getAll(this)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
    await loader.stop();
    if (tariffs.isNotEmpty) {
      final tariff = await showMTDialog<Tariff?>(TariffSelectView(tariffs, id!, description: reason));
      if (tariff != null) {
        loader.start();
        loader.setSaving();
        final signedContractInvoice = await contractUC.sign(tariff.id!, id!);
        if (signedContractInvoice != null) {
          // TODO: тут может менять не только тариф у РП, но и баланс. Нужно вытаскивать с бэка изменённое РП и дергать обсервер
          invoice = signedContractInvoice;
        }
        await loader.stop();
      }
    }
  }
}
