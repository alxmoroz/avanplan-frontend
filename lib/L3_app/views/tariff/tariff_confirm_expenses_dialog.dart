// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
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
        middle: _ws.subPageTitle('${loc.tariff_estimated_expenses_title} ${loc.per_month_suffix}'),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TariffExpenses(_tariff, _ws.invoice),
          MTButton.main(
            titleText: loc.tariff_sign_action_title,
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
