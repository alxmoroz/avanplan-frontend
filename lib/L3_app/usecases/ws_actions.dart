// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/ws_tariff.dart';
import '../extra/services.dart';
import '../presenters/number.dart';
import '../views/iap/iap_dialog.dart';
import '../views/workspace/ws_controller.dart';
import '../views/workspace/ws_feature_dialog.dart';

extension WSActionsUC on Workspace {
  User get me => users.firstWhereOrNull((u) => u.id == myAccountController.me?.id) ?? User.dummy;

  // bool get hpInfoRead => me.hp('INFO_READ');
  bool get hpInfoUpdate => me.hp('INFO_UPDATE');

  bool get hpProjectCreate => me.hp('PROJECT_CREATE');
  bool get hpProjectUpdate => me.hp('PROJECT_UPDATE');
  bool get hpProjectDelete => me.hp('PROJECT_DELETE');

  bool get hpProjectContentUpdate => me.hp('PROJECT_CONTENT_UPDATE');

  bool get hpSourceCreate => me.hp('SOURCE_CREATE');
  bool get hpTariffUpdate => me.hp('TARIFF_UPDATE');

  bool get hpMemberRead => me.hp('MEMBER_READ');
  bool get hpMemberDelete => me.hp('MEMBER_DELETE');
  bool get _hpOwnerUpdate => me.hp('OWNER_UPDATE');
  bool get isMine => _hpOwnerUpdate;

  Future<bool> checkBalance(String operation, {num extraMoney = 0}) async {
    final lack = extraMoney - balance;
    if (lack > 0) {
      final hasSelectPay = await replenishBalanceDialog(
        WSController(wsIn: this),
        reason: loc.error_insufficient_funds_for_operation(lack.ceil().currencyRouble, operation.toLowerCase()),
      );
      if (hasSelectPay == true) {
        // TODO: проверить навигацию. Не получится ли обновление в фоне а на текущей странице не будет изменений?
        await mainController.reload();
      }
    }
    return lack <= 0;
  }

  Future<bool> checkFeature(String toCode) async {
    bool hf = hasExpense(toCode);
    if (!hf) {
      final wsc = WSController(wsIn: this);
      await wsFeature(wsc, toCode: toCode);
      hf = hasExpense(toCode);
    }
    return hf;
  }
}
