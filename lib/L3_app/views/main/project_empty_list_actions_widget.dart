// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:gercules/L3_app/components/mt_card.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_source_presenter.dart';
import '../task/task_related_widgets/task_add_action_widget.dart';
import '../task/task_view_controller.dart';

class ProjectEmptyListActionsWidget extends StatelessWidget {
  const ProjectEmptyListActionsWidget({required this.taskController, required this.parentContext});
  final TaskViewController taskController;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      SizedBox(height: onePadding),
      H4(loc.project_list_empty_title_part1, align: TextAlign.center, padding: EdgeInsets.symmetric(horizontal: onePadding), color: darkGreyColor),
      SizedBox(height: onePadding / 2),
      ...referencesController.sourceTypes
          .map(
            (st) => MTCard(
              onTap: () => importController.importTasks(parentContext, sType: st),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // importIcon(context),
                SizedBox(width: onePadding / 3),
                st.icon,
                SizedBox(width: onePadding / 3),
                MediumText('$st'),
              ]),
            ),
          )
          .toList(),
      SizedBox(height: onePadding * 2),
      H4(loc.project_list_empty_title_part2, align: TextAlign.center, padding: EdgeInsets.symmetric(horizontal: onePadding), color: darkGreyColor),
      SizedBox(height: onePadding / 2),
      TaskAddActionWidget(taskController, parentContext: parentContext),
      SizedBox(height: onePadding),
    ]);
  }
}
