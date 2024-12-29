// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff_option.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../presenters/date.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff_option.dart';
import '../_base/loader_screen.dart';
import '../app/services.dart';
import 'usecases/tariff.dart';
import 'ws_controller.dart';

Future wsFeature(WSController wsc, {int? index, String? toCode, bool autoClose = true}) async => await showMTDialog(
      _WSFeatureDialog(wsc, index: index, toCode: toCode, autoClose: autoClose),
    );

class _WSFeatureDialog extends StatelessWidget {
  const _WSFeatureDialog(this._wsc, {this.index, this.toCode, required this.autoClose}) : assert(index != null || toCode != null);
  final WSController _wsc;
  final bool autoClose;
  final int? index;
  final String? toCode;

  Future _toggleSubscription(BuildContext context, TariffOption f) async {
    await _wsc.toggleFeatureSubscription(context, f);
    if (autoClose && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _dialog(BuildContext context) {
    final ws = _wsc.ws;
    final tariff = ws.tariff;
    // TODO: второй случай не обработана возможная ошибка
    final f = index != null ? tariff.features[index!] : tariff.option(toCode!)!;

    final subscribed = ws.hasExpense(f.code);
    final nominalPrice = f.price;
    final currentPrice = ws.finalPrice(f.code) ?? f.finalPrice;
    final consumedEndDate = ws.consumedEndDate(f.code);
    final differentPrices = nominalPrice != currentPrice;

    final dStyle = const DSmallText('').style(context);
    final dMediumStyle = const DText.medium('').style(context);

    return MTDialog(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: MTImage('promo_${f.code.toLowerCase()}', height: 320)),
          Container(
            margin: const EdgeInsets.only(top: P3),
            decoration: BoxDecoration(
                color: b3Color.resolve(context),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(DEF_BORDER_RADIUS)),
                boxShadow: [BoxShadow(blurRadius: P2, offset: const Offset(0, -P2), color: b1Color.resolve(context).withOpacity(0.42))]),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  H2(f.title, align: TextAlign.center, padding: const EdgeInsets.all(P3), maxLines: 1),
                  BaseText(f.description, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
                  const SizedBox(height: P4),
                  Text.rich(
                    TextSpan(
                      children: [
                        if (differentPrices)
                          TextSpan(text: '${consumedEndDate != null ? consumedEndDate.priceDurationPrefix : f.priceDurationPrefix} '),
                        TextSpan(
                          text: currentPrice.currencyRouble,
                          style: dMediumStyle.copyWith(color: mainColor.resolve(context)),
                        ),
                        TextSpan(text: differentPrices ? f.nextPriceLocalizedString : ' ${loc.per_month_suffix}'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: dStyle,
                  ),
                  MTButton(
                    type: subscribed ? MTButtonType.danger : MTButtonType.main,
                    titleText: subscribed ? loc.tariff_feature_unsubscribe_action_title : loc.tariff_feature_subscribe_action_title,
                    margin: const EdgeInsets.only(top: P3),
                    constrained: true,
                    onTap: () => _toggleSubscription(context, f),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      forceBottomPadding: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) => _wsc.loading ? LoaderScreen(_wsc, isDialog: true) : _dialog(context));
  }
}
