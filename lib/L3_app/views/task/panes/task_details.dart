// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_members.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/person_presenter.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(this.task);
  final Task task;

  bool get hasDescription => task.description.isNotEmpty;
  bool get hasAuthor => task.author != null;

  Widget description() => LightText(task.description, maxLines: 1000);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ListView(
      padding: padding.add(const EdgeInsets.all(P).copyWith(bottom: padding.bottom > 0 ? 0 : P)),
      children: [
        if (hasDescription) description(),
        if (hasAuthor) ...[
          const SizedBox(height: P_2),
          Row(children: [const Spacer(), task.author!.iconName()]),
        ],
      ],
    );
  }
}
