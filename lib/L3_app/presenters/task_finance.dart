// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../presenters/number.dart';
import '../theme/colors.dart';
import '../views/app/services.dart';

extension TaskFinancePresenter on Task {
  num get balance => income + expenses;

  bool get _hasExpenses => expenses < 0;
  bool get _hasIncome => income > 0;
  bool get hasTransactions => _hasIncome || _hasExpenses;
  bool get hasProfitOrLoss => _hasExpenses && _hasIncome;

  Color get balanceColor => balance == 0
      ? mainColor
      : balance < 0
          ? dangerColor
          : greenColor;

  num get _profitLossRatio => expenses != 0 ? (balance / expenses).abs() : 0;

  String get _incomeExpensesText => _hasIncome ? loc.finance_transactions_income_title(2) : loc.finance_transactions_expenses_title(2);
  String get _profitOrLossText => '${balance >= 0 ? loc.finance_profit_title : loc.finance_loss_title} ${_profitLossRatio.percents}';
  String get summaryTitle => !hasTransactions
      ? loc.finance_summary_empty_title
      : hasProfitOrLoss
          ? _profitOrLossText
          : _incomeExpensesText;
}
