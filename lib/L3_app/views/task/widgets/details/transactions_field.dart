// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/task_transactions_controller.dart';
import '../finance/transactions_dialog.dart';

class TaskTransactionsField extends StatelessWidget {
  const TaskTransactionsField(this._controller, {super.key, this.compact = false, this.hasMargin = false});

  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task;
  TaskTransactionsController get _trController => _controller.transactionsController;
  num get _trCount => _trController.transactionsCount;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.finance.index),
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      leading: const FinanceIcon(),
      value: _trCount > 0 ? BaseText(loc.transaction_count(_trCount), maxLines: 1) : null,
      trailing: D3.medium('${_task.balance.currency}₽', color: _task.balance >= 0 ? greenColor : dangerColor),
      compact: compact,
      onTap: () => transactionsDialog(_trController),
    );
  }
}
