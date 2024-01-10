// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';

class TaskDescriptionField extends StatelessWidget {
  const TaskDescriptionField(this._controller, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    final maxLines = _task.isTask ? 20 : 2;
    return MTField(
      _controller.fData(TaskFCode.description.index),
      leading: DescriptionIcon(color: _task.canEdit ? mainColor : f2Color),
      value: _task.hasDescription
          ? SelectableLinkify(
              text: _task.description,
              style: BaseText('', maxLines: maxLines).style(context),
              linkStyle: BaseText('', maxLines: maxLines, color: mainColor).style(context),
              onOpen: (link) async => await launchUrlString(link.url),
              minLines: 1,
              maxLines: maxLines,
            )
          : null,
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      crossAxisAlignment: _task.isTask && _task.hasDescription ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      onTap: _task.canEdit ? _controller.titleController.editDescription : null,
    );
  }
}
