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
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/status.dart';
import '../../usecases/title.dart';

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
  bool doneBtnHover = false;
  bool delBtnHover = false;
  bool taskEditing = false;

  final tfIndex = TaskFCode.title.index;

  static const doneIconSize = P6;
  static const deleteIconSize = P4;

  @override
  void initState() {
    if (task.creating) controller.setFocus(tfIndex);
    super.initState();
  }

  Future<bool> delete() async {
    setState(() => taskEditing = true);

    if (widget.onDelete != null) await widget.onDelete!();
    return false;
  }

  Future toggleDone() async {
    setState(() => taskEditing = true);
    await controller.setClosed(context, !task.closed);
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
        if (task.isCheckItem)
          MTButton.icon(
            DoneIcon(
              task.closed,
              size: doneIconSize,
              color: task.closed ? (doneBtnHover ? mainColor : greenLightColor) : (doneBtnHover ? greenColor : mainColor),
              solid: task.closed,
            ),
            padding: const EdgeInsets.symmetric(vertical: P).copyWith(left: P3),
            margin: const EdgeInsets.only(right: P2),
            onHover: (hover) => setState(() => doneBtnHover = hover),
            onTap: (task.parent?.closed == true && task.closed) ? null : toggleDone,
          )
        else
          const SizedBox(width: P3),

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
    return MTField(
      controller.fData(tfIndex),
      loading: taskEditing && task.loading == true,
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
