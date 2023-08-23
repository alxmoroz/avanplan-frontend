// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/iap_product.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_toolbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';
import '../../presenters/workspace.dart';

Future purchaseDialog(int wsId) async {
  await iapController.fetchProducts();
  return await showMTDialog<void>(StoreView(wsId));
}

class StoreView extends StatelessWidget {
  const StoreView(this.wsId);

  final int wsId;
  Workspace get ws => mainController.wsForId(wsId);

  Future _pay(IAPProduct p) async {
    Navigator.of(rootKey.currentContext!).pop();
    await iapController.pay(wsId, p);
  }

  Widget _price(IAPProduct p) {
    final hasPrice = p.price.isNotEmpty;
    final isRub = p.currencyCode.toLowerCase() == 'rub';

    return Row(
      children: [
        if (hasPrice) H3('  ${loc.for_} ${isRub ? p.rawPrice.currency : p.price}', color: f2Color),
        if (isRub) RoubleIcon(size: P * (hasPrice ? 2 : 2.5), color: hasPrice ? f2Color : mainColor),
      ],
    );
  }

  Widget _payButton(BuildContext _, int index) {
    final p = iapController.products[index];
    return MTButton.secondary(
      middle: Row(
        children: [
          H2('+ ${p.value.currency}', color: mainColor),
          _price(p),
        ],
      ),
      margin: const EdgeInsets.only(top: P),
      onTap: () => _pay(p),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(middle: ws.subPageTitle(loc.balance_replenish_store_title)),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: _payButton,
        itemCount: iapController.products.length,
      ),
    );
  }
}
