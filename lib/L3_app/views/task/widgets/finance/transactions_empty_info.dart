// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../app/services.dart';

class TransactionsEmptyInfo extends StatelessWidget {
  const TransactionsEmptyInfo(this._task, {super.key});
  final Task _task;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        MTImage(ImageName.finance.name),
        H2(loc.finance_transactions_empty_title, align: TextAlign.center, padding: const EdgeInsets.all(P3)),
        BaseText(
          _task.isGroup ? loc.finance_transactions_empty_group_hint : loc.finance_transactions_empty_hint,
          align: TextAlign.center,
          padding: const EdgeInsets.symmetric(horizontal: P6).copyWith(bottom: P3),
        ),
      ],
    );
  }
}
