// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_rich_button.dart';
import '../../extra/services.dart';
import '../../presenters/task_source_presenter.dart';
import '../task/task_add_action_widget.dart';
import '../task/task_view_controller.dart';

class ProjectEmptyListActionsWidget extends StatelessWidget {
  const ProjectEmptyListActionsWidget({required this.taskController, required this.parentContext});
  final TaskViewController taskController;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      ...sourceController.sTypes
          .map(
            (st) => MTRichButton(
              onTap: () => importController.importTasks(context, sType: st),
              icon: Row(children: [
                importIcon(context, size: onePadding * 2),
                SizedBox(width: onePadding / 2),
                st.icon(context),
              ]),
              title: '$st',
            ),
          )
          .toList(),
      TaskAddActionWidget(
        taskController,
        parentContext: parentContext,
      ),
    ]);
  }
}
