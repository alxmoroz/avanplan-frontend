// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../controllers/task_controller.dart';
import 'attachments_dialog.dart';

class TaskAttachmentsField extends StatelessWidget {
  const TaskAttachmentsField(this._controller, {super.key, this.hasMargin = false});

  final TaskController _controller;
  final bool hasMargin;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.attachment.index),
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      leading: const AttachmentIcon(),
      value: Row(children: [
        Flexible(child: BaseText(_controller.attachmentsController.attachmentsStr, maxLines: 1)),
        if (_controller.attachmentsController.attachmentsCountMoreStr.isNotEmpty)
          BaseText.f2(
            _controller.attachmentsController.attachmentsCountMoreStr,
            maxLines: 1,
            padding: const EdgeInsets.only(left: P),
          )
      ]),
      onTap: () => attachmentsDialog(_controller.attachmentsController),
    );
  }
}
