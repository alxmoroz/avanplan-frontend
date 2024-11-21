// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';

class ToolbarCreateTaskButton extends StatelessWidget {
  const ToolbarCreateTaskButton(
    this._tc, {
    this.type,
    this.compact = false,
    this.buttonType,
    super.key,
  });

  final TaskController _tc;
  final bool compact;
  final TType? type;
  final ButtonType? buttonType;

  @override
  Widget build(BuildContext context) {
    final parent = _tc.task;
    final resolvedType = type ?? (parent.isProjectWithGroups ? TType.GOAL : TType.TASK);
    final plusIcon = PlusIcon(
      color: buttonType == ButtonType.main ? mainBtnTitleColor : mainColor,
      size: buttonType != null ? P4 : DEF_TAPPABLE_ICON_SIZE,
    );
    final title = addTaskActionTitle(resolvedType);
    return buttonType == null
        ? MTListTile(
            leading: plusIcon,
            middle: !compact ? BaseText(title, maxLines: 1, color: mainColor) : null,
            bottomDivider: false,
            onTap: () => _tc.addSubtask(type: resolvedType),
          )
        : MTButton(
            leading: compact ? null : plusIcon,
            type: buttonType ?? ButtonType.main,
            titleText: compact ? null : title,
            middle: compact ? plusIcon : null,
            constrained: !compact,
            onTap: () => _tc.addSubtask(type: resolvedType),
          );
  }
}
