// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';

class TaskToggleViewButton extends StatelessWidget {
  const TaskToggleViewButton(this._controller, {this.compact = false});
  final TaskController _controller;
  final bool compact;

  Widget _icon(BuildContext context) {
    final circled = isBigScreen(context);
    final size = isBigScreen(context) ? P6 : P4;
    return _controller.showBoard ? ListIcon(circled: circled, size: size) : BoardIcon(circled: circled, size: size);
  }

  @override
  Widget build(BuildContext context) {
    final icon = _icon(context);

    return Observer(builder: (_) {
      return isBigScreen(context)
          ? MTListTile(
              leading: icon,
              middle: compact
                  ? null
                  : BaseText(
                      _controller.showBoard ? loc.task_view_mode_list_action_title : loc.task_view_mode_board_action_title,
                      color: mainColor,
                      maxLines: 1,
                    ),
              bottomDivider: false,
              onTap: _controller.toggleBoardMode,
            )
          : MTButton.secondary(
              middle: icon,
              onTap: _controller.toggleBoardMode,
              constrained: false,
            );
    });
  }
}
