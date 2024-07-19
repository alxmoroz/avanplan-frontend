// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'action_item.dart';

class TaskPopupMenu extends StatelessWidget with FocusManaging {
  const TaskPopupMenu(this._controller, this._actions, {super.key, this.compact = false});
  final TaskController _controller;
  final Iterable<TaskAction> _actions;
  final bool compact;

  void _toggle(MenuController menuController) {
    if (menuController.isOpen) {
      menuController.close();
    } else {
      menuController.open();
    }
  }

  static const _menuWidth = 230.0;

  @override
  Widget build(BuildContext context) {
    final menuController = MenuController();
    final big = isBigScreen(context);
    final offset = -_menuWidth + (big ? (compact ? P10 : _menuWidth - P4) : P6);
    return MenuAnchor(
      controller: menuController,
      style: MenuStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS))),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(_menuWidth)),
        alignment: Alignment.bottomLeft,
      ),
      crossAxisUnconstrained: false,
      alignmentOffset: Offset(offset, 0),
      menuChildren: [
        for (final ta in _actions)
          TaskActionItem(
            ta,
            onTap: () {
              menuController.close();
              _controller.taskAction(context, ta);
            },
          )
      ],
      onOpen: () => unfocus(context),
      builder: (_, MenuController menuController, Widget? child) => big
          ? MTListTile(
              leading: const MenuIcon(circled: true, size: P6),
              middle: compact ? null : BaseText(loc.task_actions_menu_title, color: mainColor, maxLines: 1),
              bottomDivider: false,
              onTap: () => _toggle(menuController),
            )
          : MTButton.icon(
              const MenuIcon(),
              padding: const EdgeInsets.symmetric(horizontal: P2),
              onTap: () => _toggle(menuController),
            ),
    );
  }
}
