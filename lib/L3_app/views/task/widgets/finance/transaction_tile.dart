// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/number.dart';

class TaskTransactionTile extends StatelessWidget {
  const TaskTransactionTile(this._transaction, {super.key, required this.bottomDivider, this.onTap});
  final TaskTransaction _transaction;
  final bool bottomDivider;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final hasDescription = _transaction.description.isNotEmpty;
    return MTListTile(
      titleText: hasDescription ? _transaction.description : _transaction.category,
      subtitle: hasDescription && _transaction.category.isNotEmpty ? SmallText(_transaction.category, maxLines: 1) : null,
      trailing: Row(children: [
        const SizedBox(width: P),
        D3('${_transaction.amount.currencySharp}$CURRENCY_SYMBOL_ROUBLE', color: _transaction.amount > 0 ? greenColor : dangerColor),
      ]),
      bottomDivider: bottomDivider,
      onTap: onTap,
    );
  }
}
