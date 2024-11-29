// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
import '../widgets/analytics/analytics_dialog.dart';

extension AnalyticsUC on TaskController {
  Future showAnalytics() async {
    // проверка наличия функции
    if (await task.ws.checkFeature(TOCode.ANALYTICS)) {
      await analyticsDialog(this);
    }
  }
}
