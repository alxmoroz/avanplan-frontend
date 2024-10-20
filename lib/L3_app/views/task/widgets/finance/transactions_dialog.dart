// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
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
import '../../../../presenters/task_finance.dart';
import '../../controllers/task_transactions_controller.dart';
import 'finance_summary_card.dart';
import 'transaction_tile.dart';
import 'transactions_empty_info.dart';

Future transactionsDialog(TaskTransactionsController controller) async => await showMTDialog(_TransactionsDialog(controller));

class _TransactionsDialog extends StatelessWidget {
  const _TransactionsDialog(this._controller);
  final TaskTransactionsController _controller;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          pageTitle: loc.tariff_option_finance_title,
          parentPageTitle: _task.title,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: P3),
            if (_task.hasTransactions) ...[
              MTAdaptive.xxs(child: FinanceSummaryCard(_task)),
              const SizedBox(height: P3),
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
                            onTap: () => _controller.editTransaction(tr),
                          );
                        },
                      ),
                      const SizedBox(height: P3),
                    ],
                  );
                },
              ),
            ] else
              TransactionsEmptyInfo(_task),
          ],
        ),
        bottomBar: MTAppBar(
          isBottom: true,
          inDialog: true,
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
                onTap: _controller.addExpense,
              ),
              const Spacer(),
              MTButton(
                leading: const PlusIcon(color: greenColor),
                titleText: loc.finance_transactions_income_title(1),
                type: ButtonType.secondary,
                titleColor: greenColor,
                padding: const EdgeInsets.symmetric(horizontal: P7),
                onTap: _controller.addIncome,
              ),
              const SizedBox(width: P3),
            ],
          ),
        ),
      ),
    );
  }
}
