// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'tariff_expenses.dart';

Future<bool?> tariffConfirmExpenses(Invoice invoice, Tariff tariff) async => await showMTDialog<bool?>(_TariffConfirmExpensesDialog(invoice, tariff));

class _TariffConfirmExpensesDialog extends StatelessWidget {
  const _TariffConfirmExpensesDialog(this._invoice, this._tariff);
  final Invoice _invoice;
  final Tariff _tariff;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        color: b2Color,
        showCloseButton: true,
        title: '${loc.tariff_estimated_expenses_title} ${loc.per_month_suffix}',
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TariffExpenses(_tariff, _invoice),
          MTButton.main(
            titleText: loc.tariff_sign_action_title,
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
