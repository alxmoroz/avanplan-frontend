// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/tariff.dart';
import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../../components/alert_dialog.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_actions.dart';
import '../../tariff/tariff_confirm_expenses_dialog.dart';
import '../ws_controller.dart';
import 'edit.dart';

extension WSTariffUC on WSController {
  Future changeTariff(BuildContext context, Tariff tariff) async {
    // TODO: ПРОВЕРИТЬ логику!
    //  проверка на возможное превышение лимитов по выбранному тарифу
    if (!ws.hasOverdraft(tariff) || await tariffConfirmExpenses(ws, tariff) == true) {
      // TODO: ПРОВЕРИТЬ логику!
      // проверка, что хватит денег на один день после смены
      if (await ws.checkBalance(loc.tariff_change_action_title, extraMoney: ws.currentExpensesPerDay)) {
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
    bool needDeleteTeam = false;
    bool? deleteTeamGranted = false;
    final subscribed = ws.subscribed(f.code);

    // Подключение функции
    if (!subscribed) {
      // TODO: проверка, что хватит денег на один день после подключения
    }
    // Отключение функции
    else {
      // Если отключаем функцию Команда и в РП есть другие участники
      if (f.code == TOCode.TEAM && ws.users.length > 1) {
        // Показываем диалог подтверждения удаления участников РП
        if (ws.hpMemberDelete) {
          needDeleteTeam = true;
          deleteTeamGranted = await showMTAlertDialog<bool>(
            loc.tariff_option_team_unsubscribe_dialog_title,
            description: loc.tariff_option_team_unsubscribe_dialog_description,
            actions: [
              MTADialogAction(result: true, title: loc.yes, type: MTDialogActionType.danger),
              MTADialogAction(result: false, title: loc.no, type: MTDialogActionType.isDefault),
            ],
            simple: true,
          );
        }
        // Есть права на смену тарифа, но нет прав на удаление участников РП
        else if (ws.hpTariffUpdate) {
          await showMTAlertDialog(
            loc.error_permission_title,
            description: loc.error_permission_description,
            actions: [MTADialogAction(result: true, title: loc.ok)],
            simple: true,
          );
        }
      }
    }

    // не надо удалять команду (отключение опции и др. случаи) либо есть разрешение на это
    if (!needDeleteTeam || deleteTeamGranted == true) {
      setLoaderScreenSaving();
      await load(() async {
        final signedInvoice = await tariffUC.upsertOption(
          ws.id!,
          ws.tariff.id!,
          f.id!,
          !subscribed,
        );
        if (!needDeleteTeam && signedInvoice != null) {
          ws.invoice = signedInvoice;
          wsMainController.refreshUI();
        }
      });
      // была отключена опция Команда с людьми - перезагружаем РП
      if (needDeleteTeam && deleteTeamGranted == true) {
        reload();
      }
    }
  }
}
