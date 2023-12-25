// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/button.dart';
import '../../../../components/circle.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/icons_workspace.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/person.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_view.dart';
import '../../../../usecases/task_tree.dart';
import '../../../../usecases/ws_actions.dart';
import '../../controllers/task_controller.dart';
import '../analytics/analytics_dialog.dart';
import '../analytics/timing_chart.dart';
import '../team/invitation_button.dart';
import '../team/team_dialog.dart';

class TaskHeaderDashboard extends StatelessWidget {
  const TaskHeaderDashboard(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  static const _dashboardHeight = 112.0;

  Widget _card(String title, {Widget? body, Function()? onTap}) => MTButton(
        padding: const EdgeInsets.all(P2),
        type: ButtonType.card,
        middle: Container(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText.f2(title, align: TextAlign.center, maxLines: 1, padding: const EdgeInsets.only(bottom: P2)),
              if (body != null) body,
            ],
          ),
        ),
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        height: _dashboardHeight,
        margin: EdgeInsets.only(top: P2),
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          // shrinkWrap: true,
          children: [
            const SizedBox(width: P3),

            /// Аналитика
            if (_task.hasAnalytics)
              _card(
                _task.overallStateTitle,
                body: _task.canShowTimeChart ? TimingChart(_task, showDueLabel: false) : null,
                onTap: () => showAnalyticsDialog(_task),
              ),

            /// Команда
            if (_task.hasTeam) ...[
              if (_task.hasAnalytics) const SizedBox(width: P2),
              _card(
                loc.team_title,
                body: _task.members.isNotEmpty
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: P8,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: index > 0 ? P2 : P),
                                  child: _task.sortedMembers[index].icon(P4, borderColor: mainColor),
                                );
                              },
                              itemCount: min(3, _task.members.length),
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
                                D4('+${_task.members.length - 3}', color: mainColor),
                              ],
                            ),
                          ],
                          const SizedBox(width: P),
                        ],
                      )
                    : Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          const MemberAddIcon(size: P8),
                          if (!_task.ws.plUsers)
                            Container(
                              padding: const EdgeInsets.only(right: P * 5 - 2, top: 2),
                              child: const RoubleCircleIcon(size: P4),
                            ),
                        ],
                      ),
                onTap: _task.members.isEmpty ? () => InvitationButton.onTap(_task) : () => showTeamDialog(_controller),
              ),
            ],

            const SizedBox(width: P3),
          ],
        ),
      ),
    );
  }
}
