// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
import '../widgets/finance/finance_summary_dialog.dart';
import '../widgets/finance/transactions_dialog.dart';

extension FinanceUC on TaskController {
  Future showFinance() async {
    // проверка наличия функции
    if (await task.ws.checkFeature(TOCode.FINANCE)) {
      final t = task;
      if (t.isTask) {
        await transactionsDialog(transactionsController);
      } else {
        await financeSummaryDialog(task);
      }
    }
  }
}
