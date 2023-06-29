// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../presenters/task_state_presenter.dart';
import '../../task/task_view.dart';
import '../../task/task_view_controller.dart';
import '../../task/widgets/tasks_group.dart';
import 'dashboard_wrapper.dart';

class MyProjects extends StatelessWidget {
  const MyProjects({this.card = false});
  final bool card;

  Task get _rootTask => mainController.rootTask;

  Future _goToProjects() async => await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: TaskParams(_rootTask.wsId));

  Widget get _contents => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NormalText(loc.project_list_my_title, align: TextAlign.center, color: greyColor),
          const SizedBox(height: P),
          card ? Expanded(child: imageForState(_rootTask.overallState)) : imageForState(_rootTask.overallState),
          H2(_rootTask.groupStateTitle(_rootTask.subtasksState), align: TextAlign.center, color: darkTextColor),
          const SizedBox(height: P),
          if (!card) ...[
            const SizedBox(height: P),
            Expanded(child: TasksGroup(_rootTask.attentionalTasks)),
            MTButton.main(titleText: loc.project_list_all_title, onTap: _goToProjects),
          ]
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => card
          ? DashboardWrapper(
              _contents,
              onTap: _goToProjects,
            )
          : _contents,
    );
  }
}
