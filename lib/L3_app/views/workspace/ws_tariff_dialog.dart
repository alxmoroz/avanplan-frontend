// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/invoice.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/tariff.dart';
import '../_base/loader_screen.dart';
import '../tariff/tariff_options.dart';
import '../tariff/tariff_selector.dart';
import 'ws_controller.dart';
import 'ws_expenses_dialog.dart';
import 'ws_features_dialog.dart';

Future showWSTariff(WSController controller) async => await showMTDialog<void>(_WSTariffDialog(controller));

class _WSTariffDialog extends StatelessWidget {
  const _WSTariffDialog(this._controller);
  final WSController _controller;
  Workspace get _ws => _controller.ws;
  Invoice get _invoice => _ws.invoice;
  Tariff get _tariff => _invoice.tariff;

  num get _expensesPerDay => _invoice.currentExpensesPerDay;
  bool get _hasExpenses => _expensesPerDay != 0;

  Iterable<TariffOption> get _subscribedFeatures => _tariff.features.where((o) => _invoice.subscribed(o.code));

  Widget get _features => MTListTile(
        leading: const FeaturesIcon(),
        titleText: loc.tariff_features_title,
        subtitle: SmallText(
          _subscribedFeatures.isNotEmpty ? _subscribedFeatures.map((mo) => mo.title).join(', ') : loc.tariff_features_no_subscriptions,
        ),
        trailing: const ChevronIcon(),
        bottomDivider: true,
        dividerIndent: P11,
        onTap: () => wsFeatures(_controller),
      );

  Widget get _tariffExpenses => MTListTile(
        leading: const BankCardIcon(),
        titleText: loc.tariff_current_expenses_title,
        subtitle: _hasExpenses
            ? Row(
                children: [
                  MTPrice(_expensesPerDay, size: AdaptiveSize.xs),
                  const SizedBox(width: P_2),
                  DSmallText(loc.per_day_suffix),
                ],
              )
            : SmallText(loc.tariff_current_expenses_zero_title, maxLines: 1),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () => showWSExpenses(_invoice),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                title: loc.tariff_title,
              ),
              body: ListView(
                shrinkWrap: true,
                children: [
                  MTCard(
                    margin: const EdgeInsets.all(P3).copyWith(top: 0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        H3(_tariff.title, padding: const EdgeInsets.all(P3).copyWith(bottom: 0)),
                        TariffOptions(_tariff),
                        const SizedBox(height: P3),
                        MTListTile(
                          middle: MTPrice(_tariff.basePrice, color: mainColor, align: TextAlign.left),
                          subtitle: BaseText.f2(loc.per_month_suffix, maxLines: 1),
                          trailing: MTButton.secondary(
                            titleText: loc.tariff_change_action_title,
                            padding: const EdgeInsets.symmetric(horizontal: P6),
                            constrained: false,
                            onTap: () => selectTariff(_controller),
                          ),
                          bottomDivider: false,
                        ),
                      ],
                    ),
                  ),
                  if (_tariff.hasFeatures) _features,
                  _tariffExpenses,
                ],
              ),
            ),
    );
  }
}
