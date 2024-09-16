// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/circle.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import 'view_settings_dialog.dart';

class TasksViewSettingsButton extends StatelessWidget {
  const TasksViewSettingsButton(this._controller, {super.key, this.compact = false});
  final TaskController _controller;
  final bool compact;

  void _tap() => showTasksViewSettingsDialog(_controller);

  Widget _icon(BuildContext context) {
    final circled = isBigScreen(context);
    final size = isBigScreen(context) ? P6 : P4;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SettingsIcon(circled: circled, size: size),
        if (_controller.task.viewSettings.hasFilters) MTCircle(color: mainColor, size: size / 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => isBigScreen(context)
          ? MTListTile(
              leading: _icon(context),
              middle: compact
                  ? null
                  : Observer(
                      builder: (_) => BaseText(
                        loc.view_settings_title,
                        color: mainColor,
                        maxLines: 1,
                      ),
                    ),
              bottomDivider: false,
              onTap: _tap,
            )
          : MTButton.secondary(
              middle: _icon(context),
              onTap: _tap,
              constrained: false,
            ),
    );
  }
}
