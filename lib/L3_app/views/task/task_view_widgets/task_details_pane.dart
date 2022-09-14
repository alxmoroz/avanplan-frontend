// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../task_view_controller.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(this.controller);
  final TaskViewController controller;
  Task get task => controller.task;

  bool get hasDescription => task.description.isNotEmpty;
  bool get hasAuthor => task.author != null;

  Widget description() => LightText(task.description, maxLines: 1000);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(onePadding).copyWith(top: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (hasDescription) ...[
          SizedBox(height: onePadding),
          description(),
        ],
        if (hasAuthor) ...[
          SizedBox(height: onePadding / 2),
          SmallText('/// ${task.author}', align: TextAlign.end),
        ],
      ]),
    );
  }
}
