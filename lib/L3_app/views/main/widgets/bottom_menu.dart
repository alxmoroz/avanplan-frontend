// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
import '../../projects/projects_view.dart';
import '../../settings/settings_menu.dart';

class BottomMenu extends StatelessWidget implements PreferredSizeWidget {
  const BottomMenu({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(P8);

  static const _btnPadding = EdgeInsets.only(top: P2);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        isBottom: true,
        color: b2Color,
        middle: Row(
          children: [
            if (tasksMainController.projects.isNotEmpty)
              Flexible(
                child: MTListTile(
                  middle: const ProjectsIcon(color: mainColor, size: P6),
                  color: Colors.transparent,
                  padding: _btnPadding,
                  bottomDivider: false,
                  onTap: () => MTRouter.navigate(ProjectsRouter, context),
                ),
              ),
            if (accountController.me != null)
              Flexible(
                child: MTListTile(
                  middle: accountController.me!.icon(P6 / 2, borderColor: mainColor),
                  color: Colors.transparent,
                  padding: _btnPadding,
                  bottomDivider: false,
                  onTap: settingsMenu,
                ),
              ),
            Flexible(
              child: MTListTile(
                middle: const RefreshIcon(),
                color: Colors.transparent,
                padding: _btnPadding,
                bottomDivider: false,
                onTap: mainController.update,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
