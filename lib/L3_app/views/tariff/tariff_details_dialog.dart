// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L3_app/components/card.dart';
import 'package:avanplan/L3_app/presenters/tariff.dart';
import 'package:avanplan/L3_app/views/tariff/tariff_options.dart';
import 'package:avanplan/L3_app/views/tariff/tariff_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
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
import '../../views/_base/loader_screen.dart';
import '../workspace/ws_controller.dart';
import 'tariff_expenses_dialog.dart';

Future tariffDetails(WSController controller) async => await showMTDialog<void>(_TariffDetailsDialog(controller));

class _TariffDetailsDialog extends StatelessWidget {
  const _TariffDetailsDialog(this._controller);
  final WSController _controller;
  Workspace get _ws => _controller.ws;
  Invoice get _invoice => _ws.invoice;
  Tariff get _tariff => _invoice.tariff;

  num get _expensesPerDay => _invoice.currentExpensesPerDay;
  bool get _hasExpenses => _expensesPerDay != 0;
  num get _balanceDays => (_ws.balance / _expensesPerDay);

  Widget get _tariffExpenses => MTListTile(
        leading: const BankCardIcon(),
        middle: Row(
          children: [
            BaseText(loc.tariff_current_expenses_title, maxLines: 1),
            const Spacer(),
            MTPrice(_expensesPerDay, size: AdaptiveSize.xs),
            const SizedBox(width: P_2),
            DSmallText(loc.per_day_suffix),
            const SizedBox(width: P_2),
          ],
        ),
        subtitle: SmallText(
          _hasExpenses
              ? '${loc.workspace_money_remaining_time_prefix} ${loc.days_count(_balanceDays.round())}'
              : loc.tariff_current_expenses_zero_title,
          maxLines: 1,
        ),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () => showTariffExpenses(_invoice),
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
                // innerHeight: _controller.reason.isNotEmpty ? P12 : P8,
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
                        H3(_tariff.title, padding: const EdgeInsets.all(P3)),
                        TariffOptions(_tariff),
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
                  _tariffExpenses,
                ],
              ),
            ),
    );
  }
}
