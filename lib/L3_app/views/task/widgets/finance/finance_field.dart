// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';
import '../../../../presenters/task_finance.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/task_transactions_controller.dart';
import 'task_finance_dialog.dart';

class FinanceField extends StatelessWidget {
  const FinanceField(this._controller, {super.key, this.compact = false, this.hasMargin = false});

  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task;
  TaskTransactionsController get _trController => _controller.transactionsController;
  num get _trCount => _trController.transactionsCount;

  static const trIconSize = P3;
  Widget get _trIcon => _task.balance < 0
      ? FinanceExpensesIcon(size: trIconSize, color: _task.balanceColor)
      : FinanceIncomeIcon(size: trIconSize, color: _task.balanceColor);

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.finance.index),
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      leading: const FinanceIcon(),
      value: _trCount > 0 ? BaseText(loc.finance_transactions_count(_trCount), maxLines: 1) : null,
      trailing: _trCount > 0
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _trIcon,
                const SizedBox(width: P_2),
                D3('${_task.balance.abs().currencySharp}$CURRENCY_SYMBOL_ROUBLE', color: _task.balanceColor),
              ],
            )
          : null,
      compact: compact,
      onTap: () => transactionsDialog(_trController),
    );
  }
}
