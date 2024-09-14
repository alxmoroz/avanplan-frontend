// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';

class TaskActionItem extends StatelessWidget {
  const TaskActionItem(this._ta, {super.key, this.compact = false, this.inPopup = true, this.onTap});
  final TaskAction _ta;
  final bool compact;
  final bool inPopup;
  final Function()? onTap;

  double _iconSize(BuildContext context) => isBigScreen(context) ? P6 : P4;

  Widget _tile(BuildContext context, {Widget? leading, String? title, Color? color}) => MTListTile(
        leading: leading,
        middle: !compact && title != null ? BaseText(title, color: color ?? mainColor, maxLines: 1) : null,
        minHeight: P4,
        bottomDivider: false,
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    final iconSize = _iconSize(context);
    switch (_ta) {
      case TaskAction.details:
        return _tile(context, leading: DocumentIcon(size: iconSize), title: loc.details);
      case TaskAction.close:
        return _tile(context, leading: DoneIcon(true, size: iconSize, color: greenColor), title: loc.action_close_title, color: greenColor);
      case TaskAction.reopen:
        return _tile(context, leading: DoneIcon(false, size: iconSize), title: loc.task_reopen_action_title);
      case TaskAction.localExport:
        return _tile(context, leading: LocalExportIcon(size: iconSize, circled: !inPopup), title: loc.task_transfer_export_action_title);
      case TaskAction.duplicate:
        return _tile(context, leading: DuplicateIcon(size: iconSize, circled: !inPopup), title: loc.task_duplicate_action_title);
      // case TaskActionType.go2source:
      //   return _task.go2SourceTitle;
      case TaskAction.unlink:
        return _tile(
          context,
          leading: LinkBreakIcon(size: iconSize, circled: !inPopup),
          title: loc.task_unlink_action_title,
          color: dangerColor,
        );
      case TaskAction.delete:
        return _tile(context, leading: DeleteIcon(size: iconSize, circled: !inPopup), title: loc.action_delete_title, color: dangerColor);
      default:
        return BaseText('$_ta');
    }
  }
}
