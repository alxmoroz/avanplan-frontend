// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/tariff_option.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff.dart';
import '../_base/loader_screen.dart';
import '../app/services.dart';
import '../tariff/tariff_options.dart';
import '../tariff/tariff_selector.dart';
import 'ws_controller.dart';
import 'ws_expenses_dialog.dart';
import 'ws_features_dialog.dart';

Future showWSTariff(WSController wsc) async => await showMTDialog(_WSTariffDialog(wsc));

class _WSTariffDialog extends StatelessWidget {
  const _WSTariffDialog(this._wsc);
  final WSController _wsc;
  Workspace get _ws => _wsc.ws;
  Iterable<TariffOption> get _subscribedFeatures => _ws.subscribedFeatures;
  Tariff get _tariff => _ws.tariff;

  num get _expectedDailyCharge => _ws.expectedDailyCharge;
  bool get _hasExpenses => _expectedDailyCharge != 0;

  static const _dividerIndent = P5 + DEF_TAPPABLE_ICON_SIZE;
  Widget? get _chevronMaybe => kIsWeb ? null : const ChevronIcon();

  Widget get _features => MTListTile(
        leading: const FeaturesIcon(),
        titleText: loc.tariff_features_title,
        subtitle: SmallText(
          _subscribedFeatures.isNotEmpty ? _subscribedFeatures.map((mo) => mo.title).join(', ') : loc.tariff_features_no_subscriptions,
        ),
        trailing: _chevronMaybe,
        bottomDivider: true,
        dividerIndent: _dividerIndent,
        onTap: () => wsFeatures(_wsc),
      );

  Widget get _tariffExpenses => MTListTile(
        leading: const BankCardIcon(),
        titleText: loc.tariff_current_expenses_title,
        subtitle: _hasExpenses
            ? DSmallText('${_expectedDailyCharge.currency} $CURRENCY_SYMBOL_ROUBLE ${loc.per_day_suffix}', align: TextAlign.left, color: f2Color)
            : SmallText(loc.tariff_current_expenses_zero_title, maxLines: 1),
        trailing: _chevronMaybe,
        bottomDivider: false,
        onTap: () => showWSExpenses(_ws),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _wsc.loading
          ? LoaderScreen(_wsc, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.tariff_title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  /// Карточка текущего тарифа
                  MTCard(
                    margin: const EdgeInsets.all(P3).copyWith(top: 0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        H3(_tariff.title, padding: const EdgeInsets.all(P3).copyWith(bottom: 0)),
                        TariffOptions(_ws, _tariff),
                        const SizedBox(height: P3),
                        MTListTile(
                          middle: MTPrice(_tariff.basePrice, color: mainColor, rowAlign: MainAxisAlignment.start),
                          subtitle: BaseText.f2(loc.per_month_suffix, maxLines: 1),
                          trailing: MTButton.secondary(
                            titleText: loc.tariff_change_action_title,
                            padding: const EdgeInsets.symmetric(horizontal: P6),
                            constrained: false,
                            onTap: () => selectTariff(_wsc),
                          ),
                          bottomDivider: false,
                        ),
                      ],
                    ),
                  ),

                  /// Подключенные функции
                  if (_tariff.hasFeatures) _features,

                  /// Текущие затраты
                  _tariffExpenses,
                ],
              ),
            ),
    );
  }
}
