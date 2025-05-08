// Copyright (c) 2024. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/circle.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/ws_member.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/members.dart';
import 'dashboard_card.dart';

class MTDashboardTeamCard extends StatelessWidget {
  const MTDashboardTeamCard(this._tc, {super.key});
  final TaskController _tc;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;

    return MTDashboardCard(
      loc.team_title,
      hasLeftMargin: t.hasGroupAnalytics || t.hasGroupFinance,
      body: t.members.isNotEmpty
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: P8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: min(3, t.activeMembers.length),
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: index > 0 ? P2 : P),
                        child: t.activeMembers[index].icon(P4),
                      );
                    },
                  ),
                ),
                if (t.members.length > 3) ...[
                  const SizedBox(width: P3),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      MTCircle(
                        size: P8,
                        color: Colors.transparent,
                        border: Border.all(width: 2, color: mainColor.resolve(context)),
                      ),
                      D3('+${t.members.length - 3}', color: mainColor),
                    ],
                  ),
                ],
                const SizedBox(width: P),
              ],
            )
          : const MemberAddIcon(size: P8),
      onTap: _tc.showTeam,
    );
  }
}
