// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_view.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/state.dart';
import '../analytics/analytics_dialog.dart';
import '../analytics/timing_chart.dart';
import '../finance/finance_summary_card.dart';
import '../wiki/wiki_main_page.dart';
import 'dashboard_card.dart';
import 'team_card.dart';

class TaskHeaderDashboard extends StatelessWidget {
  const TaskHeaderDashboard(this._tc, {super.key});
  final TaskController _tc;

  static const _dashboardHeight = 112.0;

  Widget _analyticsCard(Task t) {
    final overallStateTitle = t.canShowTimeChart ? _tc.overallStateTitle : '';
    return MTDashboardCard(
      t.canShowTimeChart ? overallStateTitle : loc.tariff_option_analytics_title,
      body: t.canShowTimeChart
          ? TimingChart(_tc, showDueLabel: false)
          : BaseText.f3(overallStateTitle, maxLines: 2, align: TextAlign.center, padding: const EdgeInsets.only(top: P)),
      onTap: () => analyticsDialog(_tc),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tc.task;
      final content = Container(
        height: _dashboardHeight,
        margin: const EdgeInsets.only(top: P2),
        child: ListView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          children: [
            /// Аналитика
            if (t.hasGroupAnalytics) _analyticsCard(t),

            /// Финансы
            if (t.hasGroupFinance) ...[
              if (t.hasGroupAnalytics) const SizedBox(width: P2),
              FinanceSummaryCard(t),
            ],

            /// Команда
            if (t.isProject) MTDashboardTeamCard(_tc),

            /// Описание
            if (t.hasDescription || _tc.canEdit)
              MTDashboardCard(
                t.hasDescription ? '' : loc.description,
                hasLeftMargin: t.isProject || t.hasGroupAnalytics || t.hasGroupFinance,
                body: t.hasDescription
                    ? Container(constraints: const BoxConstraints(minWidth: 200), child: BaseText.f2(t.description, maxLines: 4))
                    : const DescriptionIcon(),
                onTap: () => showWikiMainPageDialog(_tc),
              ),
          ],
        ),
      );

      return _tc.settingsController.viewMode.isBoard
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: P3),
              child: content,
            )
          : MTAdaptive(
              padding: const EdgeInsets.symmetric(horizontal: P3),
              child: content,
            );
    });
  }
}
