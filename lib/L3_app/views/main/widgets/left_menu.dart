// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/adaptive.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons_workspace.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../components/vertical_toolbar.dart';
import '../../../components/vertical_toolbar_controller.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/person.dart';
import '../../app/app_title.dart';
import '../../settings/settings_menu.dart';

class LeftMenu extends StatelessWidget implements PreferredSizeWidget {
  const LeftMenu(this._controller, {super.key});
  final VerticalToolbarController _controller;
  bool get _compact => _controller.compact;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return VerticalToolbar(
        _controller,
        rightSide: false,
        child: Column(
          children: [
            if (isBigScreen(context))
              MTListTile(
                middle: AppTitle(compact: _compact),
                bottomDivider: false,
                onTap: router.goMain,
              ),
            MTListTile(
              leading: const ProjectsIcon(color: mainColor, size: P6),
              middle: _compact ? null : BaseText(loc.project_list_title, maxLines: 1),
              bottomDivider: false,
              onTap: router.goProjects,
            ),
            const Spacer(),
            // if (isWeb)
            //   MTListTile(
            //     leading: const RefreshIcon(),
            //     middle: _compact ? null : BaseText(loc.refresh_action_title, color: mainColor, maxLines: 1),
            //     bottomDivider: false,
            //     onTap: mainController.reload,
            //   ),
            if (accountController.me != null)
              MTListTile(
                leading: accountController.me!.icon(P6 / 2, borderColor: mainColor),
                middle: _compact ? null : BaseText('${accountController.me!}', maxLines: 1),
                bottomDivider: false,
                onTap: settingsMenu,
              )
          ],
        ),
      );
    });
  }
}
