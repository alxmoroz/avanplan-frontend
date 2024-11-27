// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
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

Future transactionsDialog(TaskTransactionsController trc) async => await showMTDialog(_TransactionsDialog(trc));

class _TransactionsDialog extends StatelessWidget {
  const _TransactionsDialog(this._trc);
  final TaskTransactionsController _trc;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final t = _trc.t;
        return MTDialog(
          topBar: MTTopBar(pageTitle: loc.tariff_option_finance_title, parentPageTitle: t.title),
          body: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: P3),
              if (t.hasTransactions) ...[
                MTAdaptive.xxs(child: FinanceSummaryCard(t)),
                const SizedBox(height: P3),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _trc.sortedTransactionsDates.length,
                  itemBuilder: (_, index) {
                    final trDate = _trc.sortedTransactionsDates[index];
                    final trG = _trc.transactionsGroups[trDate]!;

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
                              onTap: () => _trc.editTransaction(tr),
                            );
                          },
                        ),
                        const SizedBox(height: P3),
                      ],
                    );
                  },
                ),
              ] else
                TransactionsEmptyInfo(t),
            ],
          ),
          bottomBar: MTBottomBar(
            middle: Row(
              children: [
                const SizedBox(width: P3),
                MTButton(
                  leading: const PlusIcon(color: dangerColor),
                  titleText: loc.finance_transactions_expenses_title(1),
                  type: MTButtonType.secondary,
                  titleColor: dangerColor,
                  padding: const EdgeInsets.symmetric(horizontal: P7),
                  onTap: _trc.addExpense,
                ),
                const Spacer(),
                MTButton(
                  leading: const PlusIcon(color: greenColor),
                  titleText: loc.finance_transactions_income_title(1),
                  type: MTButtonType.secondary,
                  titleColor: greenColor,
                  padding: const EdgeInsets.symmetric(horizontal: P7),
                  onTap: _trc.addIncome,
                ),
                const SizedBox(width: P3),
              ],
            ),
          ),
        );
      },
    );
  }
}
