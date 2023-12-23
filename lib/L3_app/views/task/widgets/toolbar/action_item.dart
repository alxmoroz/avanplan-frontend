// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';

class TaskActionItem extends StatelessWidget {
  const TaskActionItem(this._at);
  final TaskActionType _at;
  double get _iconSize => isBigScreen ? P6 : P4;

  Widget _tile({Widget? leading, String? title, Color? color}) => Row(children: [
        Container(width: _iconSize + _iconSize / 3, child: leading, alignment: Alignment.centerLeft),
        if (title != null) Expanded(child: BaseText(title, color: color ?? mainColor, maxLines: 1)),
      ]);

  @override
  Widget build(BuildContext context) {
    switch (_at) {
      case TaskActionType.details:
        return _tile(leading: DocumentIcon(size: _iconSize), title: loc.details);
      case TaskActionType.close:
        return _tile(leading: DoneIcon(true, size: _iconSize, color: greenColor), title: loc.close_action_title, color: greenColor);
      case TaskActionType.reopen:
        return _tile(leading: DoneIcon(false, size: _iconSize), title: loc.task_reopen_action_title);
      case TaskActionType.localExport:
        return _tile(leading: LocalExportIcon(size: _iconSize), title: loc.task_transfer_export_action_title);
      case TaskActionType.duplicate:
        return _tile(leading: DuplicateIcon(size: _iconSize), title: loc.task_duplicate_action_title);
      // case TaskActionType.go2source:
      //   return _task.go2SourceTitle;
      case TaskActionType.unlink:
        return _tile(
          leading: LinkBreakIcon(size: _iconSize),
          title: loc.task_unlink_action_title,
          color: warningColor,
        );
      case TaskActionType.delete:
        return _tile(leading: DeleteIcon(size: _iconSize), title: loc.delete_action_title, color: dangerColor);
      default:
        return BaseText('$_at');
    }
  }
}
