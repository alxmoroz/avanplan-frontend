// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
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

class TaskChecklistItem extends StatelessWidget {
  const TaskChecklistItem(this._controller, this._index);
  final SubtasksController _controller;
  final int _index;

  @override
  Widget build(BuildContext context) {
    final taskController = _controller.taskControllers.elementAt(_index);
    final task = taskController.task;
    final isCheckItem = task.isCheckItem;

    final fData = taskController.fData(TaskFCode.title.index);
    final teController = taskController.teController(TaskFCode.title.index);

    final fNode = taskController.focusNode(TaskFCode.title.index);
    fNode?.addListener(() => _controller.refresh());

    final roText = teController?.text.isNotEmpty == true ? teController!.text : taskController.titleController.titlePlaceholder;

    return MTField(
      fData,
      loading: taskController.task.loading == true,
      minHeight: P8,
      value: Slidable(
        key: ObjectKey(taskController),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {},
            confirmDismiss: () async => await _controller.deleteTask(taskController),
          ),
          children: [
            SlidableAction(
              onPressed: (_) async => await _controller.deleteTask(taskController),
              backgroundColor: dangerColor.resolve(context),
              foregroundColor: b3Color.resolve(context),
              icon: CupertinoIcons.delete,
              label: loc.delete_action_title,
            ),
          ],
        ),
        child: Row(
          children: [
            if (isCheckItem)
              MTButton.icon(
                DoneIcon(task.closed, size: P6, color: task.closed ? f3Color : greenColor, solid: task.closed),
                padding: const EdgeInsets.only(left: P3, right: P3),
                onTap: () => taskController.statusController.setStatus(task, close: true),
              ),
            Expanded(
              child: Stack(
                children: [
                  MTTextField(
                    keyboardType: TextInputType.multiline,
                    controller: teController,
                    autofocus: _index == _controller.taskControllers.length - 1,
                    margin: EdgeInsets.only(left: isCheckItem ? 0 : P3, right: P3),
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: taskController.titleController.titlePlaceholder,
                      hintStyle: const BaseText('', maxLines: 1, color: f3Color).style(context),
                    ),
                    style: const BaseText('', maxLines: 1).style(context),
                    onChanged: (str) => _controller.editTitle(taskController, str),
                    onSubmitted: (_) => _controller.addTask(),
                    focusNode: fNode,
                  ),
                  if (fNode?.hasFocus == false)
                    Container(
                      color: b3Color.resolve(context),
                      padding: EdgeInsets.only(left: isCheckItem ? 0 : P3, right: P3),
                      height: P8,
                      alignment: Alignment.centerLeft,
                      child: BaseText(roText, maxLines: 2, color: task.closed ? f3Color : null),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      dividerIndent: P3 + (isCheckItem ? P8 + P : 0),
      dividerEndIndent: P3,
      bottomDivider: _index < _controller.taskControllers.length - 1,
      onSelect: () => _controller.setFocus(true, taskController),
    );
  }
}
