// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_overview_presenter.dart';

class TaskStateIndicator extends StatelessWidget {
  const TaskStateIndicator(this.task, {this.inCard = false});
  final Task task;
  final bool inCard;

  @override
  Widget build(BuildContext context) {
    final color = inCard ? darkGreyColor : task.stateColor ?? darkGreyColor;
    final inCardText = task.stateTextDetails ?? task.stateTextTitle;

    final title = Row(
      mainAxisAlignment: !inCard ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        task.stateIcon(context, size: onePadding * (inCard ? 1.5 : 2), color: color),
        SizedBox(width: onePadding / 3),
        inCard ? SmallText(inCardText, color: color) : NormalText(task.stateTextTitle, color: color),
      ],
    );

    return Column(
      children: [
        title,
        if (!inCard && task.stateTextDetails != null) ...[
          SizedBox(height: onePadding / 4),
          MediumText(task.stateTextDetails!, color: color),
        ],
      ],
    );
  }
}
