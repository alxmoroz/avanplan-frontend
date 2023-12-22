// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../controllers/task_controller.dart';

class TaskViewToggleButton extends StatelessWidget {
  const TaskViewToggleButton(this._controller);
  final TaskController _controller;

  Widget _switchPart(BuildContext context, Widget icon, bool active) => Container(
        decoration: active
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: b3Color.resolve(context),
              )
            : null,
        width: P8,
        height: MIN_BTN_HEIGHT,
        child: icon,
      );

  @override
  Widget build(BuildContext context) {
    return MTButton.secondary(
      color: b1Color,
      middle: Row(children: [
        _switchPart(context, ListIcon(active: !_controller.showBoard), !_controller.showBoard),
        _switchPart(context, BoardIcon(active: _controller.showBoard), _controller.showBoard),
      ]),
      onTap: _controller.toggleMode,
      constrained: false,
    );
  }
}
