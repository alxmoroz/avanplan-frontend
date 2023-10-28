// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/iap_product.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';

Future purchaseDialog(int wsId) async {
  await iapController.getProducts();
  return await showMTDialog<void>(StoreView(wsId));
}

class StoreView extends StatelessWidget {
  const StoreView(this.wsId);

  final int wsId;
  Workspace get ws => wsMainController.wsForId(wsId);

  Future _pay(IAPProduct p) async {
    Navigator.of(rootKey.currentContext!).pop();
    await iapController.pay(wsId, p);
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
      margin: EdgeInsets.only(top: index == 0 ? P : P3),
      onTap: () => _pay(p),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.balance_replenish_store_title),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: _payButton,
        itemCount: iapController.products.length,
      ),
    );
  }
}
