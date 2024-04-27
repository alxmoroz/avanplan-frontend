// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../presenters/task_type.dart';
import 'create_project_controller.dart';

class CreateProjectButton extends StatelessWidget {
  const CreateProjectButton(
    this._controller, {
    super.key,
    this.compact = false,
    this.type,
  });
  final CreateProjectController _controller;
  final bool compact;
  final ButtonType? type;

  Widget _plusIcon(BuildContext context) => PlusIcon(
        color: type == ButtonType.main ? mainBtnTitleColor : mainColor,
        size: type != null ? P4 : P6,
        circled: canShowVerticalBars(context) && type == null,
      );

  @override
  Widget build(BuildContext context) {
    final plusIcon = _plusIcon(context);
    return canShowVerticalBars(context) && type == null
        ? MTListTile(
            leading: plusIcon,
            middle: !compact ? BaseText(addSubtaskActionTitle(null), maxLines: 1, color: mainColor) : null,
            bottomDivider: false,
            onTap: () => _controller.startCreate(context),
          )
        : MTButton(
            margin: EdgeInsets.only(right: compact ? P2 : 0),
            type: type ?? ButtonType.main,
            leading: compact ? null : plusIcon,
            titleText: compact ? null : addSubtaskActionTitle(null),
            middle: compact ? plusIcon : null,
            constrained: !compact,
            onTap: () => _controller.startCreate(context),
          );
  }
}
