// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/constants.dart';
import '../../../extra/services.dart';
import '../task_related_widgets/task_card.dart';
import '../task_view_controller.dart';
import 'task_filter_dropdown.dart';

class TaskListView extends StatelessWidget {
  const TaskListView(this.controller);
  final TaskViewController controller;

  Widget cardBuilder(BuildContext context, int index) {
    final taskId = controller.filteredTasks.elementAt(index).id;
    return TaskCard(mainController.taskForId(taskId));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          SizedBox(height: controller.hasFilters ? 0 : onePadding / 2),
          if (controller.hasFilters) ...[
            TaskFilterDropdown(controller),
          ],
          Expanded(
            child: ListView.builder(
              itemBuilder: cardBuilder,
              itemCount: controller.filteredTasks.length,
            ),
          ),
        ],
      ),
    );
  }
}
