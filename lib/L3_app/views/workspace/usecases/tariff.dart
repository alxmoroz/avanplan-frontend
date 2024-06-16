// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/tariff.dart';
import '../../../../L1_domain/entities_extensions/invoice.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_actions.dart';
import '../../tariff/tariff_confirm_expenses_dialog.dart';
import '../ws_controller.dart';

extension WSTariffUC on WSController {
  Future changeTariff(BuildContext context, Tariff tariff) async {
    final invoice = ws.invoice;
    // TODO: ПРОВЕРИТЬ логику!
    //  проверка на возможное превышение лимитов по выбранному тарифу
    if (!invoice.hasOverdraft(tariff) || await tariffConfirmExpenses(invoice, tariff) == true) {
      // TODO: ПРОВЕРИТЬ логику!
      // проверка, что хватит денег на один день после смены
      if (await ws.checkBalance(loc.tariff_change_action_title, extraMoney: invoice.currentExpensesPerDay)) {
        setLoaderScreenSaving();
        await load(() async {
          final signedInvoice = await tariffUC.sign(tariff.id!, wsDescriptor.id!);
          if (signedInvoice != null) {
            ws.invoice = signedInvoice;
            wsMainController.refreshUI();
          }
        });
        if (context.mounted) Navigator.of(context).pop();
      }
    }
  }

  Future toggleFeatureSubscription(BuildContext context, TariffOption f) async {
    final invoice = ws.invoice;
    final tariff = invoice.tariff;
    final subscribed = invoice.subscribed(f.code);
    if (!subscribed) {
      print('проверка, что хватит денег на один день после подключения');
    } else {
      if (f.code == TOCode.TEAM) {
        print('проверка при отключении команды');
      }
    }

    setLoaderScreenSaving();
    await load(() async {
      final signedInvoice = await tariffUC.upsertOption(
        ws.id!,
        tariff.id!,
        f.id!,
        !subscribed,
      );
      if (signedInvoice != null) {
        ws.invoice = signedInvoice;
        wsMainController.refreshUI();
      }
    });
    if (context.mounted) Navigator.of(context).pop();
  }
}
