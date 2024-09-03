// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';
import '../actions/done_button.dart';
import 'parent_title.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this._controller, {super.key});
  final TaskController _controller;

  static const _minHeight = P8;

  @override
  Widget build(BuildContext context) {
    final titleIndex = TaskFCode.title.index;

    return Observer(
      builder: (_) {
        final t = _controller.task;
        final roText = H1(t.title, color: t.isInbox ? f2Color : null);
        final header = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Хлебная крошка - Название родителя
            if (t.parent != null) TaskParentTitle(_controller),

            /// Название
            MTField(
              _controller.fData(titleIndex),
              leading: t.isTask ? TaskDoneButton(_controller) : null,
              value: t.canEdit
                  ? MTTextField(
                      controller: _controller.teController(titleIndex),
                      autofocus: t.creating,
                      margin: EdgeInsets.zero,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: _controller.titlePlaceholder,
                        hintStyle: const H1('', color: f3Color).style(context),
                      ),
                      style: roText.style(context),
                      onChanged: _controller.setTitle,
                    )
                  : Container(height: _minHeight, alignment: Alignment.centerLeft, child: roText),
              padding: EdgeInsets.zero,
              crossAxisAlignment: CrossAxisAlignment.start,
              color: Colors.transparent,
              minHeight: _minHeight,
            ),
          ],
        );
        return t.isTask
            ? Padding(padding: const EdgeInsets.symmetric(horizontal: P3), child: header)
            : _controller.showBoard
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: P3),
                    child: header,
                  )
                : MTAdaptive(
                    padding: const EdgeInsets.symmetric(horizontal: P3),
                    child: header,
                  );
      },
    );
  }
}
