// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
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
    return MTListTile(
      titleText: _transaction.description,
      subtitle: SmallText(_transaction.category, maxLines: 1),
      trailing: Row(children: [
        const SizedBox(width: P),
        D3.medium('${_transaction.amount.currencySharp}₽', color: _transaction.amount > 0 ? greenColor : dangerColor),
        const SizedBox(width: P),
        const ChevronIcon(),
      ]),
      bottomDivider: bottomDivider,
      onTap: onTap,
    );
  }
}
