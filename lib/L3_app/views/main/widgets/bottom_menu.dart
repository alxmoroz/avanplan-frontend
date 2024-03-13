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
import 'inbox_add_task_button.dart';

class BottomMenu extends StatelessWidget implements PreferredSizeWidget {
  const BottomMenu({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(P8);

  static const _btnPadding = EdgeInsets.only(top: P2);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          MTAppBar(
            isBottom: true,
            color: b2Color,
            middle: Row(
              children: [
                Flexible(
                  child: MTListTile(
                    middle: const ProjectsIcon(color: mainColor, size: P6),
                    color: Colors.transparent,
                    padding: _btnPadding,
                    bottomDivider: false,
                    onTap: () => MTRouter.navigate(ProjectsRouter, context),
                  ),
                ),
                const Spacer(),
                const SizedBox(width: P11 + P4),
                Flexible(
                  child: accountController.me != null
                      ? MTListTile(
                          middle: accountController.me!.icon(P6 / 2, borderColor: mainColor),
                          color: Colors.transparent,
                          padding: _btnPadding,
                          bottomDivider: false,
                          onTap: settingsMenu,
                        )
                      : const Spacer(),
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
          const Positioned(
            top: -P2,
            child: InboxAddTaskButton(),
          ),
        ],
      ),
    );
  }
}
