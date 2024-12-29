// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/number.dart';
import '../../../../presenters/task_finance.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/task_transactions_controller.dart';
import 'transactions_dialog.dart';

class FinanceField extends StatelessWidget {
  const FinanceField(this._tc, {super.key, this.compact = false, this.hasMargin = false});

  final TaskController _tc;
  final bool compact;
  final bool hasMargin;

  TaskTransactionsController get _trc => _tc.transactionsController;

  Widget get _balance {
    final t = _tc.task;
    return DText(
      '$CURRENCY_SYMBOL_ROUBLE ${t.balance.abs().humanValueStr}',
      color: t.balanceColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasTransactions = _trc.hasTransactions;
    final canEdit = _tc.canEditFinance;

    return MTField(
      _tc.fData(TaskFCode.finance.index),
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      leading: FinanceIcon(color: canEdit ? mainColor : f3Color),
      value: hasTransactions
          ? BaseText(
              loc.finance_transactions_count(_trc.transactionsCount),
              maxLines: 1,
              color: canEdit ? null : f2Color,
            )
          : null,
      trailing: hasTransactions ? _balance : null,
      compact: compact,
      onTap: canEdit ? () => transactionsDialog(_trc) : null,
    );
  }
}
