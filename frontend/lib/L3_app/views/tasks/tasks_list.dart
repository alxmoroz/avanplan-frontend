// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/text_widgets.dart';

// TODO: заготовка для виджета для вьюхи управления задачами

class TasksList extends StatelessWidget {
  const TasksList({required this.goal});

  final Goal goal;

  Widget taskBuilder(BuildContext context, int index) {
    final task = goal.tasks.elementAt(index);
    return ListTile(
      title: NormalText(task.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: taskBuilder,
      itemCount: goal.tasks.length,
    );
  }
}
