// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_badge.dart';
import '../../../components/mt_card.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';

class TaskOverviewAdvices extends StatelessWidget {
  const TaskOverviewAdvices(this.task);

  final Task task;

  Widget _filteredToiButton(BuildContext context, String title, int count) {
    return MTCard(
      padding: EdgeInsets.all(onePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: NormalText(title)),
          MTBadge('$count'),
          SizedBox(width: onePadding / 4),
          chevronIcon(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (task.hasNoDueToi) _filteredToiButton(context, loc.task_state_no_due_details, task.noDueToiCount),
        if (task.hasEmptyToi) _filteredToiButton(context, loc.task_count(0), task.emptyToiCount),
        if (task.hasNoProgressToi) _filteredToiButton(context, loc.task_state_no_progress_details, task.noProgressToiCount),
        if (task.hasClosableToi) _filteredToiButton(context, loc.task_state_closable_title, task.closableToiCount),
      ],
    );
  }
}
