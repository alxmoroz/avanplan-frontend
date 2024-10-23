// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/adaptive.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../components/vertical_toolbar.dart';
import '../../../components/vertical_toolbar_controller.dart';
import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../../presenters/user.dart';
import '../../projects/projects_view.dart';
import '../../settings/settings_dialog.dart';
import '../../task/task_route.dart';
import '../main_view.dart';

class LeftMenu extends StatelessWidget implements PreferredSizeWidget {
  const LeftMenu(this._controller, {super.key});
  final VerticalToolbarController _controller;
  bool get _compact => _controller.compact;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);

  BoxDecoration _selectedDecoration(BuildContext context) {
    final topShadowColor = b1Color.resolve(context);
    final selectedColor = b2Color.resolve(context);
    return BoxDecoration(
      color: b2Color.resolve(context),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [topShadowColor, selectedColor.withAlpha(42), selectedColor],
        stops: const [0, 0.1, 1],
      ),
    );
  }

  static const _selectedSize = P5;
  static const _unselectedSize = P4;

  Widget _menuButton(BuildContext context, Widget icon, String title, bool selected, Function()? onTap) => MTListTile(
        middle: Row(
          mainAxisAlignment: _compact ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (!_compact && !selected) const SizedBox(width: (_selectedSize - _unselectedSize) / 2),
            icon,
            if (!_compact)
              BaseText(
                title,
                weight: selected ? null : FontWeight.w300,
                color: f2Color,
                maxLines: 1,
                padding: const EdgeInsets.only(left: P2),
              ),
          ],
        ),
        decoration: selected ? _selectedDecoration(context) : null,
        bottomDivider: false,
        onTap: onTap,
      );

  Widget _homeButton(BuildContext context, bool selected) => _menuButton(
        context,
        HomeIcon(size: selected ? _selectedSize : _unselectedSize),
        loc.my_tasks_upcoming_title,
        selected,
        router.goMain,
      );

  Widget _projectsButton(BuildContext context, bool selected) => _menuButton(
        context,
        ProjectsIcon(color: mainColor, size: selected ? _selectedSize : _unselectedSize),
        loc.project_list_title,
        selected,
        router.goProjects,
      );

  Widget _inboxButton(BuildContext context, bool selected) => _menuButton(
        context,
        InboxIcon(size: selected ? _selectedSize : _unselectedSize),
        loc.inbox,
        selected,
        () => router.goTaskView(tasksMainController.inbox!, direct: true),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final route = mainController.currentRoute;
      final me = myAccountController.me;
      return _controller.hidden
          ? const SizedBox()
          : VerticalToolbar(
              _controller,
              rightSide: false,
              child: Column(
                children: [
                  if (isBigScreen(context)) _homeButton(context, route is MainRoute),
                  _projectsButton(context, route is ProjectsRoute),
                  _inboxButton(context, route is InboxRoute),
                  const Spacer(),
                  if (me != null)
                    MTListTile(
                      leading: me.icon(P3, borderColor: mainColor),
                      middle: _compact ? null : BaseText('$me', maxLines: 1, color: f2Color),
                      bottomDivider: false,
                      onTap: settingsDialog,
                    )
                ],
              ),
            );
    });
  }
}
