// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L3_app/components/colors_base.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';
import '../../../../presenters/task_finance.dart';
import 'finance_summary_dialog.dart';

class FinanceSummaryCard extends StatelessWidget {
  const FinanceSummaryCard(this._task, {super.key});
  final Task _task;

  @override
  Widget build(BuildContext context) {
    final hasTransactions = _task.hasTransactions;
    final title = BaseText(_task.summaryTitle, align: TextAlign.center, maxLines: 2, color: hasTransactions ? f2Color : f3Color);
    return MTButton(
      type: ButtonType.card,
      padding: const EdgeInsets.all(P2),
      onTap: () => financeSummaryDialog(_task),
      middle: Container(
        constraints: const BoxConstraints(maxWidth: 250),
        child: hasTransactions
            ? Column(
                children: [
                  title,
                  const SizedBox(height: P2),
                  D2('${_task.balance.abs().currencySharp}$CURRENCY_SYMBOL_ROUBLE', color: _task.balanceColor),
                  const SizedBox(height: P2),
                ],
              )
            : Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText.f2(loc.tariff_option_finance_title, maxLines: 1),
                  const SizedBox(height: P2),
                  title,
                ],
              ),
      ),
    );
  }
}
