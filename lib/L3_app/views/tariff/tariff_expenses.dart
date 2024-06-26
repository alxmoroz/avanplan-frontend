// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/tariff.dart';
import 'tariff_expense.dart';

class TariffExpenses extends StatelessWidget {
  const TariffExpenses(this._ws, {this.tariff, super.key});
  // NB! Тариф и РП совпадают в частном случае только. Поэтому отдельные аргументы
  final Workspace _ws;
  final Tariff? tariff;

  Tariff get _tariff => tariff ?? _ws.tariff;
  bool get _isMyTariff => _tariff.id == _ws.tariff.id;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        /// базовая цена
        MTListTile(
          middle: Row(children: [BaseText.f2(loc.tariff_title, maxLines: 1), BaseText(' ${_tariff.title}', maxLines: 1)]),
          trailing: MTPrice(_tariff.basePrice, size: AdaptiveSize.s),
          bottomDivider: false,
        ),

        /// опции с затратами
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final to = _ws.expensiveOptions[index];
            final ad = _ws.ad(to.code)!;
            return TariffExpenseTile(to, ad, isMyTariff: _isMyTariff);
          },
          itemCount: _ws.expensiveOptions.length,
        ),

        /// подключенные функции
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final to = _ws.expensiveFeatures[index];
            final ad = _ws.ad(to.code)!;
            return TariffExpenseTile(to, ad, isMyTariff: _isMyTariff);
          },
          itemCount: _ws.expensiveFeatures.length,
        ),

        /// всего
        MTListTile(
          middle: BaseText.medium(loc.total_title),
          trailing: MTPrice(_ws.overallExpectedMonthlyCharge(_tariff), size: AdaptiveSize.m, color: mainColor),
          margin: const EdgeInsets.only(top: P3),
          bottomDivider: false,
        ),

        /// информация о тарифе - ссылка
        MTButton(
          middle: BaseText(loc.tariff_details_action_title, color: mainColor, maxLines: 1),
          margin: const EdgeInsets.only(top: P3),
          onTap: () => launchUrlString(_tariff.detailsUri),
        ),
        if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
      ],
    );
  }
}
