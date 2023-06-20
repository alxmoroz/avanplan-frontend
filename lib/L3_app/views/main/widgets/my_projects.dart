// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_state_presenter.dart';
import '../../task/task_view.dart';
import '../../task/task_view_controller.dart';
import 'dashboard_wrapper.dart';

class MyProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootTask = mainController.rootTask;
    return DashboardWrapper(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NormalText(loc.project_list_my_title, align: TextAlign.center, color: lightGreyColor),
          Expanded(
            child: imageForState(rootTask.overallState),
          ),
          H3(rootTask.groupStateTitle(rootTask.subtasksState), align: TextAlign.center),
          const SizedBox(height: P),
        ],
      ),
      onTap: () async => await Navigator.of(context).pushNamed(TaskView.routeName, arguments: TaskParams(rootTask.wsId)),
    );
  }
}
