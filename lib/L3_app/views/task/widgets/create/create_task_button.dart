// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/presenters/task_tree.dart';
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
    this._tc, {
    this.type,
    this.compact = false,
    this.margin,
    this.buttonType,
    super.key,
  });

  final TaskController _tc;
  final bool compact;
  final TType? type;
  final EdgeInsets? margin;
  final ButtonType? buttonType;

  Task get _parent => _tc.task;

  Widget _plusIcon(BuildContext context) => PlusIcon(
        color: buttonType == ButtonType.main ? mainBtnTitleColor : mainColor,
        size: buttonType != null ? P4 : DEF_TAPPABLE_ICON_SIZE,
      );

  TType? get _type => type ?? (_parent.isProjectWSubgroups ? TType.GOAL : null);

  void _addSubtask() => _tc.addSubtask(type: _type);

  @override
  Widget build(BuildContext context) {
    final plusIcon = _plusIcon(context);
    final title = addSubtaskActionTitle(_parent, type: _type);
    return isBigScreen(context) && buttonType == null
        ? MTListTile(
            leading: plusIcon,
            middle: !compact ? BaseText(title, maxLines: 1, color: mainColor) : null,
            bottomDivider: false,
            onTap: _addSubtask,
          )
        : MTButton(
            leading: compact ? null : plusIcon,
            margin: margin,
            type: buttonType ?? ButtonType.main,
            titleText: compact ? null : title,
            middle: compact ? plusIcon : null,
            constrained: !compact,
            onTap: _addSubtask,
          );
  }
}
