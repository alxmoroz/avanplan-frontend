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

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton(
    TaskController parentTaskController, {
    super.key,
    bool compact = false,
    EdgeInsets? margin,
    ButtonType? type,
  })  : _parentTaskController = parentTaskController,
        _type = type,
        _compact = compact,
        _margin = margin;

  final TaskController _parentTaskController;
  final bool _compact;
  final EdgeInsets? _margin;
  final ButtonType? _type;

  Task get _parent => _parentTaskController.task;

  Widget _plusIcon(BuildContext context) => PlusIcon(
        color: _type == ButtonType.main ? mainBtnTitleColor : mainColor,
        size: _type != null ? P4 : P6,
        circled: isBigScreen(context) && _type == null,
      );

  @override
  Widget build(BuildContext context) {
    final plusIcon = _plusIcon(context);
    return isBigScreen(context) && _type == null
        ? MTListTile(
            leading: plusIcon,
            middle: !_compact ? BaseText(addSubtaskActionTitle(_parent), maxLines: 1, color: mainColor) : null,
            bottomDivider: false,
            onTap: _parentTaskController.addSubtask,
          )
        : MTButton(
            leading: _compact ? null : plusIcon,
            margin: _margin,
            type: _type ?? ButtonType.main,
            titleText: _compact ? null : addSubtaskActionTitle(_parent),
            middle: _compact ? plusIcon : null,
            constrained: !_compact,
            onTap: _parentTaskController.addSubtask,
          );
  }
}
