// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:gercules/L3_app/components/mt_constrained.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_card.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../task/task_related_widgets/task_add_action_widget.dart';
import '../task/task_view_controller.dart';

class ProjectEmptyListActionsWidget extends StatelessWidget {
  const ProjectEmptyListActionsWidget({required this.taskController});
  final TaskViewController taskController;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      const SizedBox(height: P),
      if (referencesController.sourceTypes.isNotEmpty) ...[
        H4(loc.project_list_empty_title_part1, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P), color: darkGreyColor),
        const SizedBox(height: P_2),
        ...referencesController.sourceTypes
            .map(
              (st) => MTConstrained(
                MTCardButton(
                  onTap: () => importController.importTasks(context, sType: st),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    // importIcon(context),
                    const SizedBox(width: P_3),
                    st.icon,
                    const SizedBox(width: P_3),
                    MediumText('$st'),
                  ]),
                ),
              ),
            )
            .toList(),
        const SizedBox(height: P2),
        H4(loc.project_list_empty_title_part2, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P), color: darkGreyColor),
        const SizedBox(height: P_2),
        TaskAddActionWidget(taskController),
      ],
      const SizedBox(height: P),
    ]);
  }
}
