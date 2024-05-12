// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
import '../../../../components/text_field.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/status.dart';
import '../../usecases/title.dart';

class TaskChecklistItem extends StatefulWidget {
  const TaskChecklistItem(this._taskIn, {super.key, required this.bottomDivider, this.onSubmit, this.onDelete});
  final Task _taskIn;
  final bool bottomDivider;
  final Function()? onSubmit;
  final Function()? onDelete;

  @override
  State<StatefulWidget> createState() => _TaskChecklistItemState();
}

class _TaskChecklistItemState extends State<TaskChecklistItem> {
  late final TaskController controller;

  Task get task => controller.task;

  bool _fieldHover = false;
  bool _doneBtnHover = false;
  bool _delBtnHover = false;

  double get _minHeight => P10;

  bool _taskEditing = false;

  @override
  void initState() {
    controller = TaskController(taskIn: widget._taskIn);
    if (widget._taskIn.creating) controller.setTitleFocus();
    super.initState();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _delete() async {
    setState(() => _taskEditing = true);

    if (widget.onDelete != null) await widget.onDelete!();
    return false;
  }

  Future _toggleDone() async {
    setState(() => _taskEditing = true);
    await controller.setClosed(context, !task.closed);
  }

  Widget _fieldValue(BuildContext context) {
    final teController = controller.teController(TaskFCode.title.index);
    final roText = teController?.text.isNotEmpty == true ? teController!.text : controller.titlePlaceholder;
    final fNode = controller.focusNode(TaskFCode.title.index);
    fNode?.addListener(() => setState(() {}));
    final hasFocus = fNode?.hasFocus == true;
    final tfMaxLines = hasFocus ? 1 : 5;

    final tfPadding = EdgeInsets.only(left: task.isCheckItem ? 0 : P3, right: _fieldHover ? 0 : P3);
    const doneIconSize = P6;
    const deleteIconSize = P4;
    return Row(
      children: [
        if (task.isCheckItem)
          MTButton.icon(
            DoneIcon(
              task.closed,
              size: doneIconSize,
              color: task.closed ? (_doneBtnHover ? mainColor : greenLightColor) : (_doneBtnHover ? greenColor : mainColor),
              solid: task.closed,
            ),
            padding: EdgeInsets.symmetric(vertical: (_minHeight - doneIconSize) / 2).copyWith(left: P3, right: 0),
            margin: const EdgeInsets.only(right: P2),
            onHover: (hover) => setState(() => _doneBtnHover = hover),
            onTap: (task.parent?.closed == true && task.closed) ? null : _toggleDone,
          ),
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Opacity(
                opacity: hasFocus ? 1 : 0,
                child: MTTextField(
                  keyboardType: TextInputType.multiline,
                  controller: teController,
                  autofocus: false,
                  margin: tfPadding,
                  maxLines: tfMaxLines,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: controller.titlePlaceholder,
                    hintStyle: const BaseText('', maxLines: 1, color: f3Color).style(context),
                  ),
                  style: BaseText('', maxLines: tfMaxLines, color: task.closed && !hasFocus ? f3Color : null).style(context),
                  onChanged: (str) => controller.editTitle(str),
                  onSubmitted: widget.onSubmit != null ? (_) => widget.onSubmit!() : null,
                  focusNode: fNode,
                ),
              ),
              if (!hasFocus)
                Container(
                  color: Colors.transparent,
                  padding: tfPadding,
                  constraints: BoxConstraints(minHeight: _minHeight),
                  alignment: Alignment.centerLeft,
                  child: Linkify(
                    text: roText,
                    maxLines: tfMaxLines,
                    style: BaseText('', maxLines: tfMaxLines, color: task.closed ? f3Color : null).style(context),
                    linkStyle: const BaseText('', color: mainColor).style(context),
                    onOpen: (link) async => await launchUrlString(link.url),
                  ),
                ),
            ],
          ),
        ),
        if (_fieldHover)
          MTButton.icon(
            DeleteIcon(color: _delBtnHover ? dangerColor : f2Color, size: deleteIconSize),
            padding: EdgeInsets.symmetric(vertical: (_minHeight - deleteIconSize) / 2).copyWith(left: 0, right: P3),
            margin: const EdgeInsets.only(left: P2),
            onHover: (hover) => setState(() => _delBtnHover = hover),
            onTap: _delete,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final fData = controller.fData(TaskFCode.title.index);
    return MTField(
      fData,
      loading: _taskEditing && task.loading == true,
      minHeight: _minHeight,
      value: isWeb
          ? _fieldValue(context)
          : Slidable(
              key: ObjectKey(widget._taskIn),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {},
                  confirmDismiss: _delete,
                ),
                children: [
                  SlidableAction(
                    onPressed: (_) async => await _delete(),
                    backgroundColor: dangerColor.resolve(context),
                    foregroundColor: b3Color.resolve(context),
                    icon: CupertinoIcons.delete,
                    label: loc.delete_action_title,
                  ),
                ],
              ),
              child: _fieldValue(context),
            ),
      padding: EdgeInsets.zero,
      dividerIndent: task.isCheckItem ? P11 : P3,
      dividerEndIndent: P3,
      bottomDivider: widget.bottomDivider,
      onHover: isWeb ? (hover) => setState(() => _fieldHover = hover) : null,
      onTap: controller.setTitleFocus,
    );
  }
}
