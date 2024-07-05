// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/tariff.dart';
import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/button.dart';
import '../../../components/images.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_actions.dart';
import '../../tariff/tariff_confirm_expenses_dialog.dart';
import '../ws_controller.dart';
import 'edit.dart';

extension WSTariffUC on WSController {
  Future changeTariff(BuildContext context, Tariff tariff) async {
    // TODO: неверная логика перехода с тарифа, где были включены функции
    // TODO: сначала нужно отключить платные функции, потом уже проверять наличие средств для перехода
    // информация о предстоящих тратах при переходе на тариф, где будут затраты с учётом текущего потребления услуг
    if (ws.expectedDailyCharge == 0 || await tariffConfirmExpenses(ws, tariff) == true) {
      // проверка, что хватит денег на один день после смены
      if (await ws.checkBalance(loc.tariff_change_action_title, extraMoney: ws.expectedDailyCharge)) {
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
    final subscribed = ws.hasExpense(f.code);

    // Подключение функции
    if (!subscribed) {
      // проверка, что хватит денег на один день после подключения
      if (!await ws.checkBalance(loc.promo_features_subscribe_title, extraMoney: ws.expectedDailyCharge)) return;
    }
    // Отключение функции
    else {
      // Если отключаем функцию Команда и в РП есть другие участники
      if (f.code == TOCode.TEAM && ws.users.length > 1) {
        // Показываем диалог подтверждения удаления участников РП
        if (ws.hpMemberDelete) {
          needDeleteTeam = true;
          deleteTeamGranted = await showMTAlertDialog<bool>(
            title: loc.tariff_option_team_unsubscribe_dialog_title,
            description: loc.tariff_option_team_unsubscribe_dialog_description,
            actions: [
              MTDialogAction(result: true, title: loc.action_yes_title, type: ButtonType.danger),
              MTDialogAction(result: false, title: loc.action_no_title),
            ],
          );
        }
        // Есть права на смену тарифа, но нет прав на удаление участников РП
        else if (ws.hpTariffUpdate) {
          await showMTAlertDialog(
            imageName: ImageName.privacy.name,
            title: loc.error_permission_title,
            description: loc.error_permission_description,
            actions: [MTDialogAction(result: true, title: loc.ok)],
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
