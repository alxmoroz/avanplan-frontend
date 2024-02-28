// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/iap_product.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/services/platform.dart';
import '../../../main.dart';
import '../../components/button.dart';
import '../../components/circular_progress.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';

Future<bool?> replenishBalanceDialog(int wsId, {String reason = ''}) async {
  iapController.reset();
  if (languageCode != 'ru' || !isIOS) {
    iapController.getProducts(isAppStore: isIOS);
  }

  return await showMTDialog<bool?>(_StoreDialog(wsId, reason), maxWidth: SCR_XS_WIDTH);
}

class _StoreDialog extends StatelessWidget {
  const _StoreDialog(this._wsId, this._reason);

  final int _wsId;
  final String _reason;

  Workspace get ws => wsMainController.ws(_wsId);

  Future _pay(IAPProduct p) async {
    Navigator.of(rootKey.currentContext!).pop(true);
    await iapController.pay(_wsId, p);
  }

  Widget _payButton(BuildContext _, int index) {
    final p = iapController.products[index];
    final hasPrice = p.price.isNotEmpty;
    return MTButton.secondary(
      middle: Row(
        children: [
          D3('+ ${p.value.currency}${hasPrice ? '' : '₽'}', color: mainColor),
          if (hasPrice) D4(' ${loc.for_} ${p.price}', color: f2Color),
        ],
      ),
      margin: const EdgeInsets.only(top: P3),
      onTap: () => _pay(p),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.balance_replenish_store_title),
      body: Observer(
        builder: (_) => ListView(
          shrinkWrap: true,
          children: [
            if (_reason.isNotEmpty) BaseText(_reason, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3)),
            if (!iapController.paymentMethodSelected) ...[
              MTButton.secondary(titleText: 'AppStore', onTap: iapController.getAppStoreProducts),
              const SizedBox(height: P3),
              MTButton.secondary(titleText: 'ЮMoney', onTap: iapController.getYMProducts),
            ] else
              iapController.loading
                  ? const SizedBox(height: P * 30, child: Center(child: MTCircularProgress()))
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: _payButton,
                      itemCount: iapController.products.length,
                    ),
            if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
          ],
        ),
      ),
    );
  }
}
