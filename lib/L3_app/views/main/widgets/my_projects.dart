// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_shadowed.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_state.dart';
import '../../my_projects/my_projects_view.dart';
import '../../task/widgets/tasks_group.dart';

class MyProjects extends StatelessWidget {
  const MyProjects({this.compact = true});
  final bool compact;

  Future _goToProjects() async => await Navigator.of(rootKey.currentContext!).pushNamed(MyProjectsView.routeName);

  Widget get _contents => MTCardButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NormalText(loc.project_list_title, align: TextAlign.center, color: greyColor),
            const SizedBox(height: P),
            compact ? Expanded(child: imageForState(mainController.projectsState)) : imageForState(mainController.projectsState),
            H2(groupStateTitle(mainController.projectsState), align: TextAlign.center, color: darkTextColor),
            const SizedBox(height: P),
          ],
        ),
        onTap: _goToProjects,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => compact
          ? _contents
          : Column(
              children: [
                _contents,
                const SizedBox(height: P),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: P_2),
                    child: MTShadowed(
                      child: TasksGroup(mainController.attentionalProjects),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
