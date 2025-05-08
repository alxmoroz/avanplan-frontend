// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../presenters/number.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../../views/_base/loader_screen.dart';
import '../app/services.dart';
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
  const _StoreDialog(this._wsc, this._reason, this._iapC);

  final WSController _wsc;
  final String _reason;
  final IAPController _iapC;

  Widget _payButton(BuildContext context, int index) {
    final p = _iapC.products[index];
    final hasPrice = p.price.isNotEmpty;
    return MTButton.secondary(
      middle: Row(
        children: [
          D3('+ ${p.value.currency}${hasPrice ? '' : CURRENCY_SYMBOL_ROUBLE}', color: mainColor),
          if (hasPrice) D3(' ${loc.for_} ${p.price}', color: f2Color),
        ],
      ),
      margin: const EdgeInsets.only(top: P3),
      onTap: () async {
        Navigator.of(context).pop(true);
        await _iapC.pay(_wsc.ws, p);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _iapC.loading
          ? LoaderScreen(_iapC, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.balance_replenish_store_title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  if (_reason.isNotEmpty) BaseText(_reason, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3)),
                  if (!_iapC.paymentMethodSelected) ...[
                    const SizedBox(height: P2),
                    MTButton.secondary(titleText: 'AppStore', onTap: _iapC.getAppStoreProducts),
                    const SizedBox(height: P3),
                    MTButton.secondary(titleText: 'ЮMoney', onTap: _iapC.getYMProducts),
                  ] else
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: _payButton,
                      itemCount: _iapC.products.length,
                    ),
                ],
              ),
              forceBottomPadding: true,
            ),
    );
  }
}
