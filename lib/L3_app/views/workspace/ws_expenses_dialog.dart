// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../components/colors_base.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../tariff/tariff_expenses.dart';

Future showWSExpenses(Invoice invoice) async => await showMTDialog<void>(_WSExpensesDialog(invoice));

class _WSExpensesDialog extends StatelessWidget {
  const _WSExpensesDialog(this._invoice);
  final Invoice _invoice;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        color: b2Color,
        showCloseButton: true,
        title: '${loc.tariff_current_expenses_title} ${loc.per_month_suffix}',
      ),
      body: TariffExpenses(_invoice.tariff, _invoice),
    );
  }
}
