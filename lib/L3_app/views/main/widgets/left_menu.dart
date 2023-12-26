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
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/person.dart';
import '../../my_tasks/my_tasks_view.dart';
import '../../projects/projects_view.dart';
import '../../settings/settings_menu.dart';
import 'app_title.dart';

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
        : GestureDetector(
            child: Observer(builder: (_) {
              final compact = leftMenuController.compact;
              return Container(
                width: leftMenuController.width + MediaQuery.paddingOf(context).left,
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
                        middle: AppTitle(compact: compact),
                        bottomDivider: false,
                        onTap: popTop,
                      ),
                      if (tasksMainController.projects.isNotEmpty)
                        MTListTile(
                          leading: const ProjectsIcon(color: mainColor, size: P6),
                          middle: compact ? null : BaseText(loc.project_list_title, maxLines: 1),
                          trailing: compact ? null : const ChevronIcon(),
                          dividerIndent: P6 + P5,
                          bottomDivider: tasksMainController.myTasks.isNotEmpty,
                          onTap: () => _goToProjects(context),
                        ),
                      if (tasksMainController.myTasks.isNotEmpty)
                        MTListTile(
                          leading: const TasksIcon(color: mainColor, size: P6),
                          middle: compact ? null : BaseText(loc.my_tasks_title, maxLines: 1),
                          trailing: compact ? null : const ChevronIcon(),
                          bottomDivider: false,
                          onTap: () => _goToTasks(context),
                        ),
                      const Spacer(),
                      if (!kIsWeb)
                        MTListTile(
                          leading: const RefreshIcon(),
                          middle: compact ? null : BaseText(loc.refresh_action_title, color: mainColor, maxLines: 1),
                          bottomDivider: false,
                          onTap: mainController.manualUpdate,
                        ),
                      if (accountController.user != null)
                        MTListTile(
                          leading: accountController.user!.icon(P6 / 2, borderColor: mainColor),
                          middle: compact ? null : BaseText('${accountController.user!}', maxLines: 1),
                          trailing: compact ? null : const ChevronIcon(),
                          bottomDivider: false,
                          onTap: showSettingsMenu,
                        )
                    ],
                  ),
                ),
              );
            }),
            onTap: leftMenuController.toggleWidth,
            // onHorizontalDragUpdate: _controller.swiped,
          );
  }
}
