// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/number.dart';
import '../../../../presenters/task_finance.dart';
import '../../../../presenters/task_type.dart';
import 'transactions_empty_info.dart';

Future financeSummaryDialog(Task task) async => await showMTDialog<void>(_FinanceSummaryDialog(task));

class _FinanceSummaryDialog extends StatelessWidget {
  const _FinanceSummaryDialog(this._task);
  final Task _task;

  @override
  Widget build(BuildContext context) {
    final hasIncome = _task.income > 0;
    final hasExpenses = _task.expenses < 0;
    return MTDialog(
      topBar: MTAppBar(
        middle: _task.subPageTitle(loc.tariff_option_finance_title),
        showCloseButton: true,
        color: b2Color,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          if (_task.hasTransactions) ...[
            MTListGroupTitle(
              margin: const EdgeInsets.symmetric(vertical: P),
              middle: BaseText(
                '${loc.total_title} ${loc.dates_period(_task.calculatedStartDate.strMedium, (_task.closedDate ?? now).strMedium)}',
                align: TextAlign.center,
              ),
            ),
            if (hasIncome)
              MTListTile(
                leading: const FinanceIncomeIcon(),
                titleText: loc.finance_transactions_income_title(2),
                trailing: DText('${_task.income.currency} $CURRENCY_SYMBOL_ROUBLE', color: greenColor),
                dividerIndent: P4 + P5,
                bottomDivider: hasExpenses,
              ),
            if (hasExpenses)
              MTListTile(
                leading: const FinanceExpensesIcon(),
                titleText: loc.finance_transactions_expenses_title(2),
                trailing: DText('${_task.expenses.abs().currency} $CURRENCY_SYMBOL_ROUBLE', color: dangerColor),
                bottomDivider: false,
              ),
            if (_task.hasProfitOrLoss)
              MTListTile(
                middle: BaseText.medium(_task.summaryTitle),
                trailing: D3.medium('${_task.balance.abs().currency} $CURRENCY_SYMBOL_ROUBLE', color: _task.balanceColor),
                margin: const EdgeInsets.only(top: P3),
                bottomDivider: false,
              ),
          ] else
            TransactionsEmptyInfo(_task),
        ],
      ),
    );
  }
}
