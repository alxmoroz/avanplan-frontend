// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../extra/services.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';

class TaskChecklistItem extends StatefulWidget {
  const TaskChecklistItem(this._controller, this._index);
  final SubtasksController _controller;
  final int _index;

  @override
  _TaskChecklistItemState createState() => _TaskChecklistItemState();
}

class _TaskChecklistItemState extends State<TaskChecklistItem> {
  SubtasksController get _controller => widget._controller;
  int get _index => widget._index;

  bool _fieldHover = false;
  bool _doneBtnHover = false;
  bool _delBtnHover = false;

  Future<bool> _delete(TaskController tc) async => await _controller.deleteTask(tc);

  Widget _fieldValue(BuildContext context, TaskController tc) {
    final teController = tc.teController(TaskFCode.title.index);
    final task = tc.task;
    final roText = teController?.text.isNotEmpty == true ? teController!.text : tc.titleController.titlePlaceholder;
    final fNode = tc.focusNode(TaskFCode.title.index);
    fNode?.addListener(() => setState(() {}));
    final hasFocus = fNode?.hasFocus == true;
    final tfMaxLines = hasFocus ? 1 : 2;

    final tfPadding = EdgeInsets.only(left: task.isCheckItem ? 0 : P3, right: _fieldHover ? 0 : P3);
    return Row(
      children: [
        if (task.isCheckItem)
          MTButton.icon(
            DoneIcon(task.closed,
                size: P6,
                color: task.closed ? (_doneBtnHover ? mainColor : greenLightColor) : (_doneBtnHover ? greenColor : null),
                solid: task.closed),
            padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P),
            onHover: (hover) => setState(() => _doneBtnHover = hover),
            onTap: (_controller.parent.closed && task.closed) ? null : () => tc.statusController.setStatus(task, close: !task.closed),
          ),
        Expanded(
          child: Stack(
            children: [
              MTTextField(
                keyboardType: TextInputType.multiline,
                controller: teController,
                autofocus: _index == _controller.taskControllers.length - 1,
                margin: tfPadding,
                maxLines: tfMaxLines,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: tc.titleController.titlePlaceholder,
                  hintStyle: const BaseText('', maxLines: 1, color: f3Color).style(context),
                ),
                style: BaseText('', maxLines: tfMaxLines, color: task.closed && !hasFocus ? f3Color : null).style(context),
                onChanged: (str) => _controller.editTitle(tc, str),
                onSubmitted: (_) => _controller.addTask(),
                focusNode: fNode,
              ),
              if (!kIsWeb && !hasFocus)
                Container(
                  color: b3Color.resolve(context),
                  padding: tfPadding,
                  height: P8,
                  alignment: Alignment.centerLeft,
                  child: BaseText(roText, maxLines: 2, color: task.closed ? f3Color : null),
                ),
            ],
          ),
        ),
        if (_fieldHover)
          MTButton.icon(
            DeleteIcon(color: _delBtnHover ? null : f2Color),
            padding: const EdgeInsets.only(left: P3, right: P3, top: P2, bottom: P2),
            onHover: (hover) => setState(() => _delBtnHover = hover),
            onTap: () async => await _delete(tc),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tc = _controller.taskControllers.elementAt(_index);
    final fData = tc.fData(TaskFCode.title.index);

    return MTField(
      fData,
      loading: tc.task.loading == true,
      minHeight: P8,
      crossAxisAlignment: CrossAxisAlignment.center,
      value: kIsWeb
          ? _fieldValue(context, tc)
          : Slidable(
              key: ObjectKey(tc),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {},
                  confirmDismiss: () async => await _delete(tc),
                ),
                children: [
                  SlidableAction(
                    onPressed: (_) async => await _delete(tc),
                    backgroundColor: dangerColor.resolve(context),
                    foregroundColor: b3Color.resolve(context),
                    icon: CupertinoIcons.delete,
                    label: loc.delete_action_title,
                  ),
                ],
              ),
              child: _fieldValue(context, tc),
            ),
      padding: EdgeInsets.zero,
      dividerIndent: P3 + (tc.task.isCheckItem ? P8 + P : 0),
      dividerEndIndent: P3,
      bottomDivider: _index < _controller.taskControllers.length - 1,
      onHover: kIsWeb ? (hover) => setState(() => _fieldHover = hover) : null,
      onTap: kIsWeb ? (_fieldHover ? null : () {}) : () => _controller.setFocus(true, tc),
    );
  }
}
