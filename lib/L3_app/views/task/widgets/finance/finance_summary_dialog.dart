// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/toolbar.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/number.dart';
import '../../../../presenters/task_finance.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';
import 'transactions_empty_info.dart';

Future financeSummaryDialog(Task task) async => await showMTDialog(_FinanceSummaryDialog(task));

class _FinanceSummaryDialog extends StatelessWidget {
  const _FinanceSummaryDialog(this._task);
  final Task _task;

  @override
  Widget build(BuildContext context) {
    final hasIncome = _task.income > 0;
    final hasExpenses = _task.expenses < 0;
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.tariff_option_finance_title, parentPageTitle: _task.title),
      body: ListView(
        shrinkWrap: true,
        children: [
          if (_task.hasTransactions) ...[
            MTListText(
              '${loc.total_title} ${loc.dates_period(_task.calculatedStartDate.strMedium, (_task.closedDate ?? now).strMedium)}',
              titleTextAlign: TextAlign.center,
              topMargin: 0,
              verticalPadding: P,
            ),
            if (hasIncome)
              MTListTile(
                leading: const FinanceIncomeIcon(),
                titleText: loc.finance_transactions_income_title(2),
                trailing: DText(_task.income.currencyRouble, color: greenColor),
                dividerIndent: P4 + P5,
                bottomDivider: hasExpenses,
              ),
            if (hasExpenses)
              MTListTile(
                leading: const FinanceExpensesIcon(),
                titleText: loc.finance_transactions_expenses_title(2),
                trailing: DText(_task.expenses.abs().currencyRouble, color: dangerColor),
                bottomDivider: false,
              ),
            if (_task.hasProfitOrLoss)
              MTListTile(
                middle: BaseText.medium(_task.summaryTitle),
                trailing: D3.medium(_task.balance.abs().currencyRouble, color: _task.balanceColor),
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
