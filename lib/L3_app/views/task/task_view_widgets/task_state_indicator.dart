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

    return Row(
      children: [
        if (!inCard) const Spacer(flex: 1),
        Expanded(
          flex: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: inCard ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              task.stateIcon(context, size: onePadding * (inCard ? 1.5 : 2), color: color),
              SizedBox(width: onePadding / 4),
              inCard ? SmallText(inCardText, color: color) : H4(inCardText, color: color),
            ],
          ),
        ),
        if (!inCard) const Spacer(flex: 1),
      ],
    );
  }
}
