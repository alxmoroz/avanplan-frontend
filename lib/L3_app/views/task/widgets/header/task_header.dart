// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';
import '../actions/done_button.dart';
import 'parent_title.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this._controller, {super.key});
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    final titleIndex = TaskFCode.title.index;

    return Observer(builder: (_) {
      final t = _controller.task;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Хлебная крошка - Название родителя
          if (t.parent != null) TaskParentTitle(_controller),

          /// Название
          MTField(
            _controller.fData(titleIndex),
            leading: t.isInbox
                ? const Padding(padding: EdgeInsets.symmetric(vertical: P), child: InboxIcon(color: f2Color))
                : t.isTask
                    ? TaskDoneButton(_controller)
                    : null,
            value: MTTextField(
              controller: _controller.teController(titleIndex),
              readOnly: !t.canEdit,
              autofocus: t.creating,
              margin: EdgeInsets.zero,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: _controller.titlePlaceholder,
                hintStyle: const H1('', color: f3Color).style(context),
              ),
              style: H1('', color: t.isInbox ? f2Color : null).style(context),
              onChanged: _controller.setTitle,
            ),
            crossAxisAlignment: CrossAxisAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: P3),
            color: Colors.transparent,
          ),
        ],
      );
    });
  }
}
