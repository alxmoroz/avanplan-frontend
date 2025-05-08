// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/gesture.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import 'action_item.dart';

class TaskPopupMenu extends StatelessWidget {
  const TaskPopupMenu(this._tc, {this.inToolbar = false, this.compact = false, super.key});
  final TaskController _tc;
  final bool compact;
  final bool inToolbar;

  void _toggle(MenuController mc) {
    if (mc.isOpen) {
      mc.close();
    } else {
      mc.open();
    }
  }

  static const _menuWidth = 230.0;

  Widget _menu(BuildContext context, Iterable<TaskAction> actions) {
    final mc = MenuController();
    final big = isBigScreen(context);
    final offset = -_menuWidth + (big ? (compact ? P10 : _menuWidth - P4) : P6);
    return MenuAnchor(
      controller: mc,
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(b2Color.resolve(context)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS))),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        fixedSize: WidgetStateProperty.all(const Size.fromWidth(_menuWidth)),
        alignment: Alignment.bottomLeft,
      ),
      crossAxisUnconstrained: false,
      alignmentOffset: Offset(offset, 0),
      menuChildren: [for (final ta in actions) ta.isDivider ? const SizedBox(height: P2) : TaskActionItem(ta, _tc, menuController: mc)],
      onOpen: unfocusAll,
      builder: (_, MenuController mc, Widget? child) => big
          ? MTListTile(
              leading: const MenuIcon(circled: true, size: DEF_TAPPABLE_ICON_SIZE),
              middle: compact ? null : BaseText(loc.task_actions_menu_title, color: mainColor, maxLines: 1),
              bottomDivider: false,
              onTap: () => _toggle(mc),
            )
          : MTButton.icon(
              const MenuIcon(),
              padding: const EdgeInsets.symmetric(horizontal: P2),
              onTap: () => _toggle(mc),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = _tc.actions(context, inToolbar: inToolbar);
    return actions.isNotEmpty ? _menu(context, actions) : const SizedBox();
  }
}
