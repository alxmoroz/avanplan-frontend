// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../presenters/number.dart';
import '../../../../presenters/task_finance.dart';
import 'finance_summary_dialog.dart';

class FinanceSummaryCard extends StatelessWidget {
  const FinanceSummaryCard(this._task, {super.key});
  final Task _task;

  @override
  Widget build(BuildContext context) {
    final hasTransactions = _task.hasTransactions;
    return MTButton(
      type: ButtonType.card,
      padding: const EdgeInsets.all(P2),
      onTap: hasTransactions ? () => financeSummaryDialog(_task) : null,
      middle: Container(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Column(
          children: [
            BaseText.f2(_task.summaryTitle),
            if (hasTransactions) ...[
              const SizedBox(height: P2),
              D2('${_task.balance.abs().currencySharp}$CURRENCY_SYMBOL_ROUBLE', color: _task.balanceColor),
              const SizedBox(height: P2),
            ],
          ],
        ),
      ),
    );
  }
}
