// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_divider.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'task_view_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.task);

  final Task task;

  TaskViewController get _controller => taskViewController;

  String get breadcrumbs {
    const sepStr = ' > ';
    String _breadcrumbs = '';
    final titles = _controller.navStack.take(_controller.navStack.length - 1).map((t) => t.title).toList();
    _breadcrumbs = titles.join(sepStr);
    return _breadcrumbs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (breadcrumbs.isNotEmpty) ...[
          SmallText(breadcrumbs),
          const MTDivider(),
        ],
        Row(children: [
          Expanded(child: H2(task.title, decoration: task.closed ? TextDecoration.lineThrough : null)),
          SizedBox(width: onePadding / 2),
          if (task.hasLink) ...[
            SizedBox(height: onePadding / 2),
            linkIcon(context, color: darkGreyColor),
          ],
        ]),
      ]),
    );
  }
}
