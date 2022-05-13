// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_card.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'smartable_header.dart';
import 'smartable_progress.dart';

class SmartableDashboard extends StatelessWidget {
  const SmartableDashboard(this.element, {this.onTap});

  final Smartable element;
  final VoidCallback? onTap;

  bool get hasSubtasks => element.tasksCount > 0;
  bool get hasLink => element.trackerId != null;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SmartableHeader(element: element),
        if (hasSubtasks) ...[
          H4(loc.smartable_dashboard_total_title(element.tasksCount), padding: EdgeInsets.symmetric(horizontal: onePadding)),
          MTCard(
            body: SmartableProgress(
              element,
              body: Row(children: [
                Expanded(child: LightText(loc.common_mark_done_btn_title)),
                H2('${element.closedTasksCount}'),
                SizedBox(width: onePadding / 2),
                chevronIcon(context),
              ]),
              padding: EdgeInsets.fromLTRB(onePadding, onePadding, onePadding / 2, onePadding),
            ),
            onTap: onTap,
          ),
        ],
      ],
    );
  }
}
