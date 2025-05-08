// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../theme/text.dart';
import '../../controllers/attachments_controller.dart';
import '../../controllers/task_controller.dart';
import 'attachments_dialog.dart';

class TaskAttachmentsField extends StatelessWidget {
  const TaskAttachmentsField(this._controller, {super.key, this.hasMargin = false});

  final TaskController _controller;
  final bool hasMargin;

  AttachmentsController get _ac => _controller.attachmentsController;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.attachment.index),
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      leading: const AttachmentIcon(),
      value: Row(children: [
        Flexible(child: BaseText(_ac.attachmentsStr, maxLines: 1)),
        if (_ac.attachmentsCountMoreStr.isNotEmpty)
          BaseText.f2(
            _ac.attachmentsCountMoreStr,
            maxLines: 1,
            padding: const EdgeInsets.only(left: P),
          )
      ]),
      onTap: () => attachmentsDialog(_ac),
    );
  }
}
