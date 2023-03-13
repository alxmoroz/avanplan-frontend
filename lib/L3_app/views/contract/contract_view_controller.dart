// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import 'tariff_select_view.dart';

part 'contract_view_controller.g.dart';

class ContractViewController extends _ContractViewControllerBase with _$ContractViewController {}

abstract class _ContractViewControllerBase with Store {
  Future changeTariff(BuildContext context, Workspace ws) async {
    final tariff = await tariffSelectDialog(ws);
    if (tariff != null) {
      loaderController.start();
      // TODO: экран ожидания смены тарифа
      // loaderController.set();
      final signedContractInvoice = await contractUC.sign(tariff.id!, ws.id!);
      if (signedContractInvoice != null) {
        ws.invoice = signedContractInvoice;
      }

      // TODO: см. как в редактировании (добавлении или удалении) задач логика
      // Navigator.of(context).pop(invoice);
      await loaderController.stop();
    }
  }
}
