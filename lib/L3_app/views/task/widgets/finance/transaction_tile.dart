// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/constants.dart';
import '../../../../components/list_tile.dart';
import '../../../../presenters/number.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';

class TaskTransactionTile extends StatelessWidget {
  const TaskTransactionTile(this._transaction, {super.key, required this.bottomDivider, this.onTap});
  final TaskTransaction _transaction;
  final bool bottomDivider;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final hasDescription = _transaction.description.isNotEmpty;
    final color = _transaction.amount > 0 ? greenColor : dangerColor;
    final decimalSep = NumberSeparators().decimalSep;
    final numParts = _transaction.amount.financeTransaction.split(decimalSep);
    final decimals = numParts[1].startsWith('0') ? '' : numParts[1];

    return MTListTile(
      titleText: hasDescription ? _transaction.description : _transaction.category,
      subtitle: hasDescription && _transaction.category.isNotEmpty ? SmallText(_transaction.category, maxLines: 1) : null,
      trailing: Row(children: [
        const SizedBox(width: P),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DText(numParts[0], color: color),
            if (decimals.isNotEmpty) ...[
              const SizedBox(width: 1),
              DText(decimalSep, color: color),
              const SizedBox(width: 2),
              DSmallText(decimals, color: color, padding: const EdgeInsets.only(bottom: 1)),
            ],
            DSmallText(' $CURRENCY_SYMBOL_ROUBLE', color: color, padding: const EdgeInsets.only(bottom: 1)),
          ],
        ),
      ]),
      bottomDivider: bottomDivider,
      onTap: onTap,
    );
  }
}
