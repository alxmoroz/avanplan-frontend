// Copyright (c) 2024. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/circle.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/ws_member.dart';
import '../../controllers/task_controller.dart';
import '../analytics/analytics_dialog.dart';
import '../analytics/timing_chart.dart';
import '../finance/finance_summary_card.dart';
import '../team/invitation_dialog.dart';
import '../team/team_dialog.dart';
import '../wiki/wiki_main_page.dart';

class TaskHeaderDashboard extends StatelessWidget {
  const TaskHeaderDashboard(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  static const _dashboardHeight = 112.0;

  Widget _card(String title, {Widget? body, bool hasLeftMargin = false, Function()? onTap}) => MTButton(
        margin: EdgeInsets.only(left: hasLeftMargin ? P2 : 0),
        padding: const EdgeInsets.all(P2),
        type: ButtonType.card,
        middle: Container(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Column(
            children: [
              if (title.isNotEmpty) BaseText.f2(title, align: TextAlign.center, maxLines: 1, padding: const EdgeInsets.only(bottom: P2)),
              if (body != null) body,
            ],
          ),
        ),
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final content = Container(
        height: _dashboardHeight,
        margin: const EdgeInsets.only(top: P2),
        child: ListView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          children: [
            /// Аналитика
            if (_task.hasAnalytics)
              _card(
                _task.canShowTimeChart ? _task.overallStateTitle : loc.tariff_option_analytics_title,
                body: _task.canShowTimeChart
                    ? TimingChart(_task, showDueLabel: false)
                    : BaseText.f3(_task.overallStateTitle, maxLines: 2, align: TextAlign.center, padding: const EdgeInsets.only(top: P)),
                onTap: () => analyticsDialog(_task),
              ),

            /// Финансы
            if (_task.hasFinance) ...[
              if (_task.hasAnalytics) const SizedBox(width: P2),
              FinanceSummaryCard(_task),
            ],

            /// Команда
            if (_task.hasTeam)
              _card(
                loc.team_title,
                hasLeftMargin: _task.hasAnalytics || _task.hasFinance,
                body: _task.members.isNotEmpty
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: P8,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: min(3, _task.activeMembers.length),
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: index > 0 ? P2 : P),
                                  child: _task.activeMembers[index].icon(P4),
                                );
                              },
                            ),
                          ),
                          if (_task.members.length > 3) ...[
                            const SizedBox(width: P3),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                MTCircle(
                                  size: P8,
                                  color: Colors.transparent,
                                  border: Border.all(width: 2, color: mainColor.resolve(context)),
                                ),
                                D3('+${_task.members.length - 3}', color: mainColor),
                              ],
                            ),
                          ],
                          const SizedBox(width: P),
                        ],
                      )
                    : const MemberAddIcon(size: P8),
                onTap: _task.members.isEmpty ? () => invite(_task) : () => showTeamDialog(_controller),
              ),

            if (_task.hasDescription || _task.canEdit)
              _card(
                _task.hasDescription ? '' : loc.description,
                hasLeftMargin: _task.hasAnalytics || _task.hasFinance || _task.hasTeam,
                body: _task.hasDescription
                    ? Container(constraints: const BoxConstraints(minWidth: 200), child: BaseText.f2(_task.description, maxLines: 4))
                    : const DescriptionIcon(),
                onTap: () => showWikiMainPageDialog(_controller),
              ),
          ],
        ),
      );

      return _controller.showBoard
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
