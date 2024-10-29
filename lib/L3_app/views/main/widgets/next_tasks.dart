// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/calendar_event.dart';
import '../../../../L1_domain/entities/next_task_or_event.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../components/adaptive.dart';
import '../../../extra/services.dart';
import '../../../views/task/widgets/tasks/card.dart';
import '../../calendar/event_card.dart';
import '../../task/controllers/task_controller.dart';
import '../../task/usecases/delete.dart';
import '../../task/widgets/analytics/state_title.dart';

class NextTasks extends StatelessWidget {
  const NextTasks({super.key});

  List<MapEntry<TaskState, List<NextTaskOrEvent>>> get _groups => mainController.nextTasksOrEventsDateGroups;

  Widget _groupedItemBuilder(int groupIndex) {
    final group = _groups[groupIndex];
    final items = group.value;
    return Column(
      children: [
        GroupStateTitle(
          group.key,
          place: StateTitlePlace.groupHeader,
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (_, index) {
            final item = items[index];
            return item.item is Task
                ? TaskCard(
                    item.item as Task,
                    showStateMark: true,
                    showParent: true,
                    bottomDivider: index < items.length - 1,
                    showAssignee: false,
                    onDelete: (t) async => await TaskController(taskIn: t).delete(),
                  )
                : EventCard(
                    item.item as CalendarEvent,
                    showStateMark: true,
                    isFirst: index == 0,
                    bottomDivider: index < items.length - 1,
                  );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTAdaptive(
      child: Observer(
        builder: (_) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => _groupedItemBuilder(index),
          itemCount: _groups.length,
        ),
      ),
    );
  }
}
