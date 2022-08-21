// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_level.dart';
import '../../../components/constants.dart';
import '../../../components/mt_divider.dart';
import '../../../components/text_widgets.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.task);
  final Task task;

  // TODO: виджет
  String get breadcrumbs {
    Iterable<String> parentsTitles(Task? task) {
      final res = <String>[];
      if (task != null && !task.isWorkspace) {
        if (task.parent != null) {
          res.addAll(parentsTitles(task.parent!));
        }
        res.add(task.title);
      }
      return res;
    }

    return parentsTitles(task.parent).join(' > ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding).copyWith(bottom: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (breadcrumbs.isNotEmpty) ...[
          SmallText(breadcrumbs),
          const MTDivider(),
        ],
        H2(task.title, decoration: task.closed ? TextDecoration.lineThrough : null),
      ]),
    );
  }
}
