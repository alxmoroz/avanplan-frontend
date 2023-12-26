// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

class LeftMenu extends StatelessWidget {
  const LeftMenu();

  Future _goToProjects(BuildContext context) async {
    popTop();
    await MTRouter.navigate(ProjectsRouter, context);
  }

  Future _goToTasks(BuildContext context) async {
    popTop();
    await MTRouter.navigate(MyTasksRouter, context);
  }

  @override
  Widget build(BuildContext context) {
    return !showLeftMenu
        ? Container()
        : Observer(
            builder: (_) => GestureDetector(
              child: Container(
                width: P12 + MediaQuery.paddingOf(context).left,
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
                        middle: MTImage(ImageName.app_icon.name, height: P6, width: P6),
                        dividerIndent: P2,
                        dividerEndIndent: P2,
                        bottomDivider: tasksMainController.projects.isNotEmpty,
                        onTap: popTop,
                      ),
                      if (tasksMainController.projects.isNotEmpty)
                        MTListTile(
                          middle: const ProjectsIcon(color: mainColor, size: P6),
                          dividerIndent: P2,
                          dividerEndIndent: P2,
                          bottomDivider: tasksMainController.myTasks.isNotEmpty,
                          onTap: () => _goToProjects(context),
                        ),
                      if (tasksMainController.myTasks.isNotEmpty)
                        MTListTile(
                          middle: const TasksIcon(color: mainColor, size: P6),
                          bottomDivider: false,
                          onTap: () => _goToTasks(context),
                        ),
                      const Spacer(),
                      if (!kIsWeb)
                        MTListTile(
                          middle: const RefreshIcon(size: P7),
                          bottomDivider: false,
                          onTap: mainController.manualUpdate,
                        ),
                      if (accountController.user != null)
                        MTListTile(
                          middle: accountController.user!.icon(P6 / 2, borderColor: mainColor),
                          bottomDivider: false,
                          onTap: showSettingsMenu,
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
