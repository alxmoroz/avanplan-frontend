// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/colors.dart';
import '../extra/services.dart';
import '../presenters/number.dart';

extension TaskFinancePresenter on Task {
  num get balance => income + expenses;
  bool get hasTransactions => income > 0 || expenses < 0;

  Color get balanceColor => balance == 0
      ? mainColor
      : balance < 0
          ? dangerColor
          : greenColor;

  num get _profitLossRatio => expenses != 0 ? (balance / expenses).abs() : 0;

  String get profitLossTitle => !hasTransactions
      ? isGroup
          ? loc.finance_transactions_empty_group_title
          : loc.finance_transactions_empty_task_title
      : '${balance >= 0 ? loc.finance_profit_title : loc.finance_loss_title} ${_profitLossRatio.percents}';
}
