// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/button.dart';
import '../../../components/constants.dart';
import '../../../components/shadowed.dart';
import '../../../components/text.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_state.dart';
import '../../projects/projects_view.dart';
import '../../task/widgets/tasks/tasks_group.dart';

class Projects extends StatelessWidget {
  const Projects({super.key, this.compact = true});
  final bool compact;

  Future _goToProjects() async => await MTRouter.navigate(ProjectsRouter, rootKey.currentContext!);

  Widget _contents(BuildContext context) {
    final overallState = tasksMainController.overallProjectsState;
    final image = imageForState(overallState, size: compact ? MediaQuery.sizeOf(context).width : null);
    return MTCardButton(
      onTap: _goToProjects,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseText.f2(loc.project_list_title, align: TextAlign.center),
          compact ? Expanded(child: image) : image,
          H2(groupStateTitle(overallState), align: TextAlign.center),
          const SizedBox(height: P),
        ],
      ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: P + P_2),
                  child: MTShadowed(
                    child: TasksGroup(tasksMainController.dashboardProjects, standalone: false),
                  ),
                ),
              ],
            ),
    );
  }
}
