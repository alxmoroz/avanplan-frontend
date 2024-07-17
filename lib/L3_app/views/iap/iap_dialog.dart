// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/services/platform.dart';
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
import '../../views/_base/loader_screen.dart';
import '../workspace/ws_controller.dart';
import 'iap_controller.dart';

Future<bool?> replenishBalanceDialog(WSController wsController, {String reason = ''}) async {
  final iapController = IAPController();
  if (languageCode != 'ru' || !isIOS) {
    iapController.getProducts(isAppStore: isIOS);
  }

  return await showMTDialog<bool?>(_StoreDialog(wsController, reason, iapController), maxWidth: SCR_XS_WIDTH);
}

class _StoreDialog extends StatelessWidget {
  const _StoreDialog(this.wsController, this.reason, this.controller);

  final WSController wsController;
  final String reason;
  final IAPController controller;

  Workspace get ws => wsController.ws;

  Widget _payButton(BuildContext context, int index) {
    final p = controller.products[index];
    final hasPrice = p.price.isNotEmpty;
    return MTButton.secondary(
      middle: Row(
        children: [
          D3('+ ${p.value.currency}${hasPrice ? '' : ROUBLE_CURRENCY_SYMBOL}', color: mainColor),
          if (hasPrice) D3(' ${loc.for_} ${p.price}', color: f2Color),
        ],
      ),
      margin: const EdgeInsets.only(top: P3),
      onTap: () async {
        Navigator.of(context).pop(true);
        await controller.pay(ws, p);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.loading
          ? LoaderScreen(controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.balance_replenish_store_title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  if (reason.isNotEmpty) BaseText(reason, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3)),
                  if (!controller.paymentMethodSelected) ...[
                    const SizedBox(height: P2),
                    MTButton.secondary(titleText: 'AppStore', onTap: controller.getAppStoreProducts),
                    const SizedBox(height: P3),
                    MTButton.secondary(titleText: 'ЮMoney', onTap: controller.getYMProducts),
                  ] else
                    controller.loading
                        ? const SizedBox(height: P * 30, child: Center(child: MTCircularProgress()))
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: _payButton,
                            itemCount: controller.products.length,
                          ),
                  if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                ],
              ),
            ),
    );
  }
}
