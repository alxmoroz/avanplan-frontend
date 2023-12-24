// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/adaptive.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/icons_workspace.dart';
import '../../../components/images.dart';
import '../../../components/list_tile.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/person.dart';
import '../../my_tasks/my_tasks_view.dart';
import '../../projects/projects_view.dart';
import '../../settings/settings_menu.dart';

class MainMenu extends StatelessWidget {
  BuildContext get _navContext => rootKey.currentContext!;
  void _popTop() => Navigator.of(_navContext).popUntil((r) => r.navigator?.canPop() != true);

  Future _goToSettings() async {
    await showSettingsMenu();
  }

  Future _goToProjects() async {
    _popTop();
    await MTRouter.navigate(ProjectsRouter, _navContext);
  }

  Future _goToTasks() async {
    _popTop();
    await MTRouter.navigate(MyTasksRouter, _navContext);
  }

  @override
  Widget build(BuildContext context) {
    return !isBigScreen
        ? Container()
        : Observer(
            builder: (_) => GestureDetector(
              child: Container(
                width: P11 + MediaQuery.paddingOf(context).left,
                decoration: BoxDecoration(
                  color: b3Color.resolve(context),
                  // borderRadius: const BorderRadius.horizontal(right: Radius.circular(DEF_BORDER_RADIUS)),
                  // border: const Border(right: BorderSide(strokeAlign: BorderSide.strokeAlignInside)),
                  // boxShadow: const [BoxShadow(offset: Offset(P, 0))],
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      MTListTile(
                        leading: MTImage(ImageName.app_icon.name, height: P5, width: P5),
                        dividerIndent: P2,
                        dividerEndIndent: P2,
                        bottomDivider: tasksMainController.projects.isNotEmpty,
                        onTap: _popTop,
                      ),
                      if (tasksMainController.projects.isNotEmpty)
                        MTListTile(
                          leading: const ProjectsIcon(color: mainColor),
                          dividerIndent: P2,
                          dividerEndIndent: P2,
                          bottomDivider: tasksMainController.myTasks.isNotEmpty,
                          onTap: _goToProjects,
                        ),
                      if (tasksMainController.myTasks.isNotEmpty)
                        MTListTile(
                          leading: const TasksIcon(color: mainColor),
                          bottomDivider: false,
                          onTap: _goToTasks,
                        ),
                      const Spacer(),
                      if (accountController.user != null)
                        MTListTile(
                          leading: accountController.user!.icon(P5 / 2, borderColor: mainColor),
                          bottomDivider: false,
                          onTap: _goToSettings,
                        )
                    ],
                  ),
                ),
                // onTap: () {},
              ),
            ),
          );
  }
}
