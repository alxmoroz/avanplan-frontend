// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'tariff_expenses.dart';

Future<bool?> tariffConfirmExpenses(Workspace ws, Tariff tariff) async => await showMTDialog<bool?>(_TariffConfirmExpensesDialog(ws, tariff));

class _TariffConfirmExpensesDialog extends StatelessWidget {
  const _TariffConfirmExpensesDialog(this._ws, this._tariff);
  final Workspace _ws;
  final Tariff _tariff;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        color: b2Color,
        showCloseButton: true,
        pageTitle: '${loc.tariff_estimated_expenses_title} ${loc.per_month_suffix}',
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TariffExpenses(_ws, tariff: _tariff),
          MTButton.main(
            titleText: loc.action_subscribe_title,
            margin: EdgeInsets.only(top: P3, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
