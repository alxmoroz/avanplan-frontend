// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../presenters/number.dart';
import '../../../../presenters/task_finance.dart';

class FinanceSummaryCard extends StatelessWidget {
  const FinanceSummaryCard(this.task, {super.key});
  final Task task;
  @override
  Widget build(BuildContext context) {
    final hasTransactions = task.hasTransactions;
    return MTAdaptive.xxs(
      child: MTCardButton(
        margin: const EdgeInsets.symmetric(vertical: P3),
        onTap: hasTransactions ? () => print('FinanceSummaryCard') : null,
        child: Column(
          children: [
            BaseText.f2(task.profitLossTitle),
            if (hasTransactions) ...[
              const SizedBox(height: P2),
              D2('${task.balance.currencySharp}$CURRENCY_SYMBOL_ROUBLE', color: task.balanceColor),
              const SizedBox(height: P2),
            ],
          ],
        ),
      ),
    );
  }
}
