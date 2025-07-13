// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_type.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
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
  final MTButtonType? buttonType;

  @override
  Widget build(BuildContext context) {
    final parent = _tc.task;
    final resolvedType = type ?? (parent.isProjectWithGroups ? TType.GOAL : TType.TASK);
    final plusIcon = PlusIcon(
      color: buttonType == MTButtonType.main ? mainBtnTitleColor : mainColor,
      size: buttonType != null ? P4 : DEF_TAPPABLE_ICON_SIZE,
    );
    final title = addTaskActionTitle(resolvedType);
    return buttonType == null
        ? MTListTile(
            color: b3Color,
            leading: plusIcon,
            middle: !compact ? BaseText(title, maxLines: 1, color: mainColor) : null,
            onTap: () => _tc.addSubtask(type: resolvedType),
          )
        : MTButton(
            leading: compact ? null : plusIcon,
            type: buttonType ?? MTButtonType.main,
            titleText: compact ? null : title,
            middle: compact ? plusIcon : null,
            constrained: !compact,
            onTap: () => _tc.addSubtask(type: resolvedType),
          );
  }
}
