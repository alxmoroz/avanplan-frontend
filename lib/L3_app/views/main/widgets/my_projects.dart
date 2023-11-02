// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/button.dart';
import '../../../components/constants.dart';
import '../../../components/shadowed.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_state.dart';
import '../../my_projects/my_projects_view.dart';
import '../../task/widgets/tasks/tasks_group.dart';

class MyProjects extends StatelessWidget {
  const MyProjects({this.compact = true});
  final bool compact;

  Future _goToProjects() async => await Navigator.of(rootKey.currentContext!).pushNamed(MyProjectsView.routeName);

  Widget _contents(BuildContext context) {
    final overallState = tasksMainController.overallProjectsState;
    final image = imageForState(overallState, size: compact ? MediaQuery.sizeOf(context).width : null);
    return MTCardButton(
      child: Column(
        children: [
          BaseText.f2(loc.project_list_title, align: TextAlign.center),
          compact ? Expanded(child: image) : image,
          H2(groupStateTitle(overallState), align: TextAlign.center),
          const SizedBox(height: P),
        ],
      ),
      onTap: _goToProjects,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => compact
          ? _contents(context)
          : ListView(
              children: [
                _contents(context),
                const SizedBox(height: P_2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: P + P_2),
                  child: MTShadowed(
                    child: TasksGroup(tasksMainController.dashboardProjects),
                  ),
                ),
              ],
            ),
    );
  }
}
