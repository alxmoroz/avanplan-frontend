// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../task/task_view.dart';
import '../../task/task_view_controller.dart';

class NoProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootTask = mainController.rootTask;
    final allClosed = rootTask.hasSubtasks;
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MTImage(allClosed ? ImageNames.ok : ImageNames.start),
          const SizedBox(height: P),
          if (allClosed)
            MTButton(
              leading: H2(loc.project_list_all_title, color: mainColor),
              middle: H2(loc.are_closed_suffix),
              onTap: () async => await Navigator.of(context).pushNamed(TaskView.routeName, arguments: TaskParams(rootTask.wsId)),
            )
          else
            H2(loc.state_no_projects_hint, align: TextAlign.center),
          const SizedBox(height: P2),
          NormalText(
            loc.projects_add_hint_title,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P2),
            maxLines: 5,
          ),
          const SizedBox(height: P),
        ],
      ),
    );
  }
}
