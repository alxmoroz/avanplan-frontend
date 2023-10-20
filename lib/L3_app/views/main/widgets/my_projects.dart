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

  Widget get _contents {
    final overallState = tasksMainController.overallProjectsState;
    final image = imageForState(overallState);
    return MTCardButton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseText.f2(loc.project_list_title, align: TextAlign.center),
          const SizedBox(height: P3),
          compact ? Expanded(child: image) : image,
          H2(groupStateTitle(overallState), align: TextAlign.center),
          const SizedBox(height: P3),
        ],
      ),
      onTap: _goToProjects,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => compact
          ? _contents
          : Column(
              children: [
                _contents,
                const SizedBox(height: P3),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: P),
                    child: MTShadowed(
                      child: TasksGroup(tasksMainController.dashboardProjects),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
