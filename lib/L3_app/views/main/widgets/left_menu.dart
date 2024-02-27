// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L2_data/services/platform.dart';
import '../../../components/adaptive.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/icons_workspace.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../components/vertical_toolbar.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/person.dart';
import '../../app/app_title.dart';
import '../../projects/projects_view.dart';
import '../../settings/settings_menu.dart';

class LeftMenu extends StatelessWidget implements PreferredSizeWidget {
  const LeftMenu({super.key});

  Future _goToProjects(BuildContext context) async {
    popTop();
    await MTRouter.navigate(ProjectsRouter, context);
  }

  @override
  Size get preferredSize => Size.fromWidth(leftMenuController.width);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final compact = leftMenuController.compact;
      return VerticalToolbar(
        leftMenuController,
        rightSide: false,
        child: Column(
          children: [
            if (isBigScreen(context))
              MTListTile(
                middle: AppTitle(compact: compact),
                bottomDivider: false,
                onTap: popTop,
              ),
            MTListTile(
              leading: const ProjectsIcon(color: mainColor, size: P6),
              middle: compact ? null : BaseText(loc.project_list_title, maxLines: 1),
              trailing: compact ? null : const ChevronIcon(),
              bottomDivider: false,
              onTap: () => _goToProjects(context),
            ),
            const Spacer(),
            if (!isWeb)
              MTListTile(
                leading: const RefreshIcon(),
                middle: compact ? null : BaseText(loc.refresh_action_title, color: mainColor, maxLines: 1),
                bottomDivider: false,
                onTap: mainController.update,
              ),
            if (accountController.me != null)
              MTListTile(
                leading: accountController.me!.icon(P6 / 2, borderColor: mainColor),
                middle: compact ? null : BaseText('${accountController.me!}', maxLines: 1),
                trailing: compact ? null : const ChevronIcon(),
                bottomDivider: false,
                onTap: settingsMenu,
              )
          ],
        ),
      );
    });
  }
}
