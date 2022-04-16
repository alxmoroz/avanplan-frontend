// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  Widget buildCardTitle() => H4(task.title, color: darkGreyColor, maxLines: 1);

  Widget buildTasksCount() {
    final tasksString = '${task.closedTasksCount} / ${task.tasksCount}';
    return H3(tasksString, color: darkGreyColor);
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return MTCard(
      onTap: onTap,
      body: Container(
        color: darkBackgroundColor.resolve(context),
        height: 70,
        child: Stack(
          children: [
            Container(
              color: (task.dueDate != null ? (task.pace >= 0 ? goodPaceColor : warningPaceColor) : borderColor).resolve(context),
              width: (task.closedRatio ?? 0) * _width,
            ),
            Padding(
              padding: EdgeInsets.all(onePadding),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCardTitle(),
                        if (task.description.isNotEmpty) SmallText(task.description, maxLines: 1),
                      ],
                    ),
                  ),
                  if (task.tasksCount > 0) buildTasksCount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
