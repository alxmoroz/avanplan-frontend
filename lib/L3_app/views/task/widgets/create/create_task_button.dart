// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton(
    this._parentTaskController, {
    this.compact = false,
    this.margin,
    this.type,
    super.key,
  });

  final TaskController _parentTaskController;
  final bool compact;
  final EdgeInsets? margin;
  final ButtonType? type;

  Task get _parent => _parentTaskController.task;

  Widget _plusIcon(BuildContext context) => PlusIcon(
        color: type == ButtonType.main ? mainBtnTitleColor : mainColor,
        size: type != null ? P4 : DEF_TAPPABLE_ICON_SIZE,
      );

  @override
  Widget build(BuildContext context) {
    final plusIcon = _plusIcon(context);
    return isBigScreen(context) && type == null
        ? MTListTile(
            leading: plusIcon,
            middle: !compact ? BaseText(addSubtaskActionTitle(_parent), maxLines: 1, color: mainColor) : null,
            bottomDivider: false,
            onTap: _parentTaskController.addSubtask,
          )
        : MTButton(
            leading: compact ? null : plusIcon,
            margin: margin,
            type: type ?? ButtonType.main,
            titleText: compact ? null : addSubtaskActionTitle(_parent),
            middle: compact ? plusIcon : null,
            constrained: !compact,
            onTap: _parentTaskController.addSubtask,
          );
  }
}
