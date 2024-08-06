// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field_inline.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';
import '../actions/done_button.dart';

class TaskChecklistItem extends StatefulWidget {
  const TaskChecklistItem(this._controller, {super.key, required this.bottomDivider, this.onSubmit, this.onDelete});
  final TaskController _controller;
  final bool bottomDivider;
  final Function()? onSubmit;
  final Function()? onDelete;

  @override
  State<StatefulWidget> createState() => _TaskChecklistItemState();
}

class _TaskChecklistItemState extends State<TaskChecklistItem> {
  TaskController get controller => widget._controller;
  Task get task => controller.task;

  bool fieldHover = false;
  bool delBtnHover = false;
  bool deleting = false;

  final tfIndex = TaskFCode.title.index;

  static const deleteIconSize = P4;

  @override
  void initState() {
    if (task.creating) controller.setFocus(tfIndex);
    super.initState();
  }

  Future<bool> delete() async {
    setState(() => deleting = true);
    if (widget.onDelete != null) await widget.onDelete!();
    return false;
  }

  Widget get tf {
    final teController = controller.teController(tfIndex)!;
    final fNode = controller.focusNode(tfIndex);
    fNode?.addListener(() => setState(() {}));
    return MTTextFieldInline(
      teController,
      style: BaseText('', color: task.closed ? f3Color : null).style(context),
      hintText: controller.titlePlaceholder,
      fNode: fNode,
      textInputAction: TextInputAction.next,
      onTap: () => controller.setFocus(tfIndex),
      onChanged: controller.setTitle,
      onSubmit: widget.onSubmit,
    );
  }

  Widget get item {
    return Row(
      children: [
        const SizedBox(width: P3),
        if (task.isCheckItem) ...[
          TaskDoneButton(controller),
          const SizedBox(width: P2),
        ],

        /// поле ввода
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: P),
            child: tf,
          ),
        ),
        if (isWeb)
          Opacity(
            opacity: fieldHover ? 1 : 0,
            child: MTButton.icon(
              DeleteIcon(color: delBtnHover ? dangerColor : f2Color, size: deleteIconSize),
              padding: const EdgeInsets.symmetric(vertical: P, horizontal: P3),
              margin: const EdgeInsets.only(left: P2),
              onHover: (hover) => setState(() => delBtnHover = hover),
              onTap: delete,
            ),
          )
        else
          const SizedBox(width: P6),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final fd = controller.fData(tfIndex);
    return MTField(
      fd,
      loading: deleting,
      value: isWeb
          ? item
          : Slidable(
              key: ObjectKey(controller),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {},
                  confirmDismiss: delete,
                ),
                children: [
                  SlidableAction(
                    onPressed: (_) async => await delete(),
                    backgroundColor: dangerColor.resolve(context),
                    foregroundColor: b3Color.resolve(context),
                    icon: CupertinoIcons.delete,
                    label: loc.action_delete_title,
                  ),
                ],
              ),
              child: item,
            ),
      padding: EdgeInsets.zero,
      dividerIndent: task.isCheckItem ? P11 : P3,
      dividerEndIndent: P3,
      bottomDivider: widget.bottomDivider,
      onHover: isWeb ? (hover) => setState(() => fieldHover = hover) : null,
      onTap: () => controller.setFocus(tfIndex),
    );
  }
}
