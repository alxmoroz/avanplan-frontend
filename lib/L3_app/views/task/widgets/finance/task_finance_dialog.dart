// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_transactions_controller.dart';
import 'finance_summary_card.dart';
import 'transaction_edit_dialog.dart';
import 'transaction_tile.dart';

Future transactionsDialog(TaskTransactionsController controller) async => await showMTDialog<void>(_TransactionsDialog(controller));

class _TransactionsDialog extends StatelessWidget {
  const _TransactionsDialog(this._controller);
  final TaskTransactionsController _controller;

  Future _editTransaction({TaskTransaction? tr, num? trSign}) async {
    await transactionEditDialog(_controller.task, transaction: tr, trSign: trSign);
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _controller.task.subPageTitle(loc.tariff_option_finance_title)),
        body: ListView(
          shrinkWrap: true,
          children: [
            FinanceSummaryCard(_controller.task),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _controller.sortedTransactionsDates.length,
              itemBuilder: (_, index) {
                final trDate = _controller.sortedTransactionsDates[index];
                final trG = _controller.transactionsGroups[trDate]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SmallText('${trDate.strMedium}, ${DateFormat.EEEE().format(trDate)}', color: f2Color, align: TextAlign.center),
                    const SizedBox(height: P2),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: trG.length,
                      itemBuilder: (_, index) {
                        final tr = trG[index];
                        return TaskTransactionTile(
                          tr,
                          bottomDivider: index < trG.length - 1,
                          onTap: () => _editTransaction(tr: tr),
                        );
                      },
                    ),
                    const SizedBox(height: P3),
                  ],
                );
              },
            ),
          ],
        ),
        bottomBar: MTAppBar(
          isBottom: true,
          color: b2Color,
          padding: EdgeInsets.only(top: P2, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          middle: Row(
            children: [
              const SizedBox(width: P3),
              MTButton(
                leading: const PlusIcon(color: dangerColor),
                titleText: loc.finance_transactions_expenses_title(1),
                type: ButtonType.secondary,
                titleColor: dangerColor,
                padding: const EdgeInsets.symmetric(horizontal: P7),
                onTap: () => _editTransaction(trSign: -1),
              ),
              const Spacer(),
              MTButton(
                leading: const PlusIcon(color: greenColor),
                titleText: loc.finance_transactions_income_title(1),
                type: ButtonType.secondary,
                titleColor: greenColor,
                padding: const EdgeInsets.symmetric(horizontal: P7),
                onTap: () => _editTransaction(trSign: 1),
              ),
              const SizedBox(width: P3),
            ],
          ),
        ),
      ),
    );
  }
}
