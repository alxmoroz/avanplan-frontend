// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_transactions_controller.dart';
import 'transaction_edit_dialog.dart';
import 'transaction_tile.dart';

Future transactionsDialog(TaskTransactionsController controller) async => await showMTDialog<void>(_TransactionsDialog(controller));

class _TransactionsDialog extends StatelessWidget {
  const _TransactionsDialog(this._controller);
  final TaskTransactionsController _controller;

  Future _editTransaction({TaskTransaction? tr}) async {
    await transactionEditDialog(_controller.task, transaction: tr);
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.tariff_option_finance_title),
        body: MTShadowed(
          topPaddingIndent: 0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.sortedTransactions.length,
            itemBuilder: (_, index) {
              final tr = _controller.sortedTransactions[index];
              return TaskTransactionTile(
                tr,
                bottomDivider: index < _controller.sortedTransactions.length - 1,
                onTap: () => _editTransaction(tr: tr),
              );
            },
          ),
        ),
        bottomBar: MTAppBar(
          isBottom: true,
          color: b2Color,
          padding: EdgeInsets.only(top: P2, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          middle: MTButton.main(titleText: '+', onTap: _editTransaction),
        ),
      ),
    );
  }
}
