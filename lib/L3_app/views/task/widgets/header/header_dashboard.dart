// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_view.dart';
import '../../controllers/task_controller.dart';
import '../analytics/analytics_dialog.dart';
import '../analytics/timing_chart.dart';
import '../team/team_dialog.dart';

class TaskHeaderDashboard extends StatelessWidget {
  const TaskHeaderDashboard(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  static const _dashboardHeight = 135.0;

  Widget _card({Widget? header, Widget? footer, Function()? onTap}) => MTAdaptive.xxs(
        child: Container(
          height: _dashboardHeight,
          child: MTCardButton(
            padding: const EdgeInsets.all(P2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (header != null) header,
                if (footer != null) footer,
              ],
            ),
            onTap: onTap,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        height: _dashboardHeight,
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: P3),

            /// Аналитика
            if (_task.hasAnalytics)
              _card(
                header: BaseText.f2(
                  _task.overallStateTitle,
                  align: TextAlign.center,
                  maxLines: 2,
                  height: 1,
                  padding: const EdgeInsets.only(bottom: P),
                ),
                footer: _task.canShowTimeChart ? TimingChart(_task, showDueLabel: false) : null,
                onTap: () => showAnalyticsDialog(_task),
              ),

            /// Команда
            if (_task.hasTeam) ...[
              if (_task.hasAnalytics) const SizedBox(width: P3),
              _card(
                header: BaseText.f2(loc.team_title, align: TextAlign.center, maxLines: 1, padding: const EdgeInsets.only(bottom: P)),
                onTap: () => showTeamDialog(_controller),
              ),
            ],

            const SizedBox(width: P3),
          ],
        ),
      ),
    );
  }
}
