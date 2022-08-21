// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/constants.dart';
import '../../../extra/services.dart';
import '../task_view_controller.dart';
import 'task_card.dart';
import 'task_filter_dropdown.dart';

class TaskListView extends StatelessWidget {
  const TaskListView(this.controller);
  final TaskViewController controller;

  Widget cardBuilder(BuildContext context, int index) {
    final task = mainController.taskForId(controller.filteredTasks.elementAt(index).id);
    // TODO: обработку клика делать внутри карточки
    return TaskCard(
      task: task,
      onTap: () => mainController.showTask(context, task),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          if (controller.hasFilters) ...[
            SizedBox(height: onePadding),
            TaskFilterDropdown(controller),
          ],
          SizedBox(height: onePadding / 2),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: cardBuilder,
            itemCount: controller.filteredTasks.length,
          ),
          SizedBox(height: onePadding),
        ],
      ),
    );
  }
}
