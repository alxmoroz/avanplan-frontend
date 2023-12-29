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
  const TaskActionItem(this._ta, {this.compact = false, this.popup = true});
  final TaskAction _ta;
  final bool compact;
  final bool popup;

  double _iconSize(BuildContext context) => isBigScreen(context) ? P6 : P4;
  double _iconPadding(BuildContext context) => compact ? 0 : (isBigScreen(context) ? P2 : P);

  Widget _tile(BuildContext context, {Widget? leading, String? title, Color? color}) => Row(children: [
        Container(width: _iconSize(context) + _iconPadding(context), child: leading, alignment: Alignment.centerLeft),
        if (!compact && title != null) Expanded(child: BaseText(title, color: color ?? mainColor, maxLines: 1)),
      ]);

  @override
  Widget build(BuildContext context) {
    final iconSize = _iconSize(context);
    switch (_ta) {
      case TaskAction.details:
        return _tile(context, leading: DocumentIcon(size: iconSize), title: loc.details);
      case TaskAction.close:
        return _tile(context, leading: DoneIcon(true, size: iconSize, color: greenColor), title: loc.close_action_title, color: greenColor);
      case TaskAction.reopen:
        return _tile(context, leading: DoneIcon(false, size: iconSize), title: loc.task_reopen_action_title);
      case TaskAction.localExport:
        return _tile(context, leading: LocalExportIcon(size: iconSize, circled: !popup), title: loc.task_transfer_export_action_title);
      case TaskAction.duplicate:
        return _tile(context, leading: DuplicateIcon(size: iconSize, circled: !popup), title: loc.task_duplicate_action_title);
      // case TaskActionType.go2source:
      //   return _task.go2SourceTitle;
      case TaskAction.unlink:
        return _tile(
          context,
          leading: LinkBreakIcon(size: iconSize, circled: !popup),
          title: loc.task_unlink_action_title,
          color: warningColor,
        );
      case TaskAction.delete:
        return _tile(context, leading: DeleteIcon(size: iconSize, circled: !popup), title: loc.delete_action_title, color: dangerColor);
      default:
        return BaseText('$_ta');
    }
  }
}
