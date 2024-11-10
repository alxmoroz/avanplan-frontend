// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/assignee.dart';
import '../../usecases/delete.dart';
import '../../usecases/duplicate.dart';
import '../../usecases/estimate.dart';
import '../../usecases/status.dart';
import '../../usecases/transfer.dart';
import '../details/task_details.dart';
import '../finance/transactions_dialog.dart';
import '../relations/relations_dialog.dart';

class TaskActionItem extends StatelessWidget {
  const TaskActionItem(this._ta, this._tc, {this.menuController, super.key, this.compact = false});
  final TaskAction _ta;
  final TaskController _tc;
  final MenuController? menuController;
  final bool compact;

  static const _iconSize = P4;

  Widget _tile({Widget? leading, String? title, Color? color, Function()? onTap}) => MTListTile(
        leading: leading,
        middle: !compact && title != null ? BaseText(title, color: color ?? mainColor, maxLines: 1) : null,
        minHeight: P4,
        bottomDivider: false,
        onTap: () {
          if (menuController != null) menuController!.close();
          if (onTap != null) onTap();
        },
      );

  @override
  Widget build(BuildContext context) {
    switch (_ta) {
      case TaskAction.details:
        return _tile(
          leading: const DocumentIcon(size: _iconSize),
          title: loc.details,
          onTap: () => showDetailsDialog(_tc),
        );
      case TaskAction.assignee:
        return _tile(
          leading: const PersonIcon(size: _iconSize),
          title: loc.task_assignee_label,
          onTap: _tc.startAssign,
        );
      case TaskAction.estimate:
        return _tile(
          leading: const EstimateIcon(size: _iconSize),
          title: loc.task_estimate_label,
          onTap: _tc.selectEstimate,
        );
      case TaskAction.finance:
        return _tile(
            leading: const FinanceIcon(size: _iconSize),
            title: loc.tariff_option_finance_title,
            onTap: () => transactionsDialog(_tc.transactionsController));
      case TaskAction.relations:
        return _tile(
          leading: const LinkIcon(size: _iconSize),
          title: loc.relations_title,
          onTap: () => relationsDialog(_tc.relationsController),
        );
      case TaskAction.close:
        return _tile(
          leading: const DoneIcon(true, size: _iconSize, color: greenColor),
          title: loc.action_close_title,
          color: greenColor,
          onTap: () => _tc.setClosed(true, canPop: true),
        );
      case TaskAction.reopen:
        return _tile(
          leading: const DoneIcon(false, size: _iconSize),
          title: loc.task_reopen_action_title,
          onTap: () => _tc.setClosed(false),
        );
      case TaskAction.localExport:
        return _tile(
          leading: const LocalExportIcon(size: _iconSize),
          title: loc.action_transfer_title,
          onTap: _tc.localExport,
        );
      case TaskAction.duplicate:
        return _tile(
          leading: const DuplicateIcon(size: _iconSize),
          title: loc.task_duplicate_action_title,
          onTap: _tc.duplicate,
        );
      case TaskAction.delete:
        return _tile(
          leading: const DeleteIcon(size: _iconSize),
          title: loc.action_delete_title,
          color: dangerColor,
          onTap: () => _tc.delete(pop: true),
        );
      default:
        return BaseText('$_ta');
    }
  }
}
