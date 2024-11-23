// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L2_data/services/platform.dart';
import '../../../components/icons.dart';
import '../../../components/list_tile.dart';
import '../../../components/text.dart';
import '../../../components/toolbar_controller.dart';
import '../../../components/vertical_toolbar.dart';
import '../../../extra/services.dart';
import 'inbox_add_task_button.dart';
import 'view_settings_dialog.dart';

class MainRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const MainRightToolbar(this._tbc, {super.key});
  final MTToolbarController _tbc;

  @override
  Size get preferredSize => Size.fromWidth(_tbc.width);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => VerticalToolbar(
        _tbc,
        child: Column(
          children: [
            // TODO: управление календарем в вебе
            if (!isWeb)
              MTListTile(
                leading: const SettingsIcon(),
                middle: _tbc.compact ? null : BaseText(loc.view_settings_title, maxLines: 1),
                bottomDivider: false,
                onTap: showViewSettingsDialog,
              ),
            const Spacer(),
            InboxAddTaskButton(compact: _tbc.compact),
          ],
        ),
      ),
    );
  }
}
