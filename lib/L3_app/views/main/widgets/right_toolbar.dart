// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../components/vertical_toolbar.dart';
import '../../../components/vertical_toolbar_controller.dart';
import 'inbox_add_task_button.dart';
import 'view_settings_dialog.dart';

class MainRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const MainRightToolbar(this._controller, {super.key});
  final VerticalToolbarController _controller;
  bool get _compact => _controller.compact;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => VerticalToolbar(
        _controller,
        child: Column(
          children: [
            MTListTile(
              leading: const SettingsIcon(),
              middle: _compact ? null : BaseText('НАСТРОЙКИ ВИДА', maxLines: 1),
              bottomDivider: false,
              onTap: showViewSettingsDialog,
            ),
            const Spacer(),
            InboxAddTaskButton(compact: _compact),
          ],
        ),
      ),
    );
  }
}
