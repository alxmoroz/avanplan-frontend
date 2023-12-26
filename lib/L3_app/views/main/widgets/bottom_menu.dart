// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/adaptive.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/icons_workspace.dart';
import '../../../components/list_tile.dart';
import '../../../components/toolbar.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/person.dart';
import '../../my_tasks/my_tasks_view.dart';
import '../../projects/projects_view.dart';
import '../../settings/settings_menu.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu();

  @override
  Widget build(BuildContext context) {
    return showLeftMenu
        ? Container()
        : Observer(
            builder: (_) => MTAppBar(
              isBottom: true,
              bgColor: b2Color,
              paddingTop: 0,
              middle: Row(
                children: [
                  if (tasksMainController.projects.isNotEmpty)
                    Flexible(
                      child: MTListTile(
                        middle: const ProjectsIcon(color: mainColor, size: P6),
                        padding: const EdgeInsets.only(top: P2),
                        color: Colors.transparent,
                        bottomDivider: false,
                        onTap: () => MTRouter.navigate(ProjectsRouter, context),
                      ),
                    ),
                  if (tasksMainController.myTasks.isNotEmpty)
                    Flexible(
                      child: MTListTile(
                        middle: const TasksIcon(color: mainColor, size: P6),
                        padding: const EdgeInsets.only(top: P2),
                        color: Colors.transparent,
                        bottomDivider: false,
                        onTap: () => MTRouter.navigate(MyTasksRouter, context),
                      ),
                    ),
                  if (accountController.user != null)
                    Flexible(
                      child: MTListTile(
                        middle: accountController.user!.icon(P6 / 2, borderColor: mainColor),
                        padding: const EdgeInsets.only(top: P2),
                        color: Colors.transparent,
                        bottomDivider: false,
                        onTap: showSettingsMenu,
                      ),
                    ),
                  Flexible(
                    child: MTListTile(
                      middle: const RefreshIcon(),
                      padding: const EdgeInsets.only(top: P2),
                      color: Colors.transparent,
                      bottomDivider: false,
                      onTap: mainController.manualUpdate,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
