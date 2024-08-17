// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field_inline.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';

class TaskDescriptionField extends StatefulWidget {
  const TaskDescriptionField(this._controller, {super.key, this.standalone = false, this.padding});
  final TaskController _controller;
  final bool standalone;
  final EdgeInsets? padding;

  @override
  State<StatefulWidget> createState() => _TaskDescriptionFieldState();
}

class _TaskDescriptionFieldState extends State<TaskDescriptionField> {
  TaskController get controller => widget._controller;
  Task get task => controller.task;
  TextEditingController get teController => controller.teController(fIndex)!;
  MTFieldData get fd => controller.fData(fIndex);

  final hintText = loc.description;
  final fIndex = TaskFCode.description.index;
  FocusNode? fNode;
  bool expanded = true;

  static const readOnlyMaxLines = 15;
  static const readOnlyShortLines = 7;
  static const expandButtonHeight = P6;

  void _fNodeListener() => setState(() {});

  @override
  void initState() {
    fNode = controller.focusNode(fIndex);
    fNode?.addListener(_fNodeListener);
    super.initState();
  }

  @override
  void dispose() {
    fNode?.removeListener(_fNodeListener);
    super.dispose();
  }

  void tap() {
    if (task.canEdit) fNode?.requestFocus();
  }

  bool _exceedROMaxLines(double maxWidth) {
    final tp = TextPainter(text: TextSpan(text: fd.text), maxLines: readOnlyMaxLines, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: maxWidth - (widget.padding?.horizontal ?? 0));
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, size) {
      return Observer(builder: (_) {
        final hasFocus = fNode?.hasFocus == true;
        bool exceedReadOnlyMaxLines = false;
        int? maxLines;

        final needCheckToggle = !hasFocus && task.isTask;
        if (needCheckToggle) {
          exceedReadOnlyMaxLines = _exceedROMaxLines(size.maxWidth);
          maxLines = hasFocus || expanded ? null : readOnlyShortLines;
        }
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MTField(
              fd,
              color: Colors.transparent,
              padding: (widget.padding ?? EdgeInsets.zero)
                  .add(EdgeInsets.only(bottom: exceedReadOnlyMaxLines && expanded && !hasFocus ? expandButtonHeight : 0)) as EdgeInsets,
              value: MTTextFieldInline(
                teController,
                key: widget.key,
                maxLines: maxLines,
                fNode: fNode,
                autofocus: widget.standalone && !task.hasDescription,
                hintText: hintText,
                style: const BaseText('', color: f2Color).style(context),
                onChanged: controller.setDescription,
                onTap: tap,
              ),
              onTap: tap,
            ),
            if (exceedReadOnlyMaxLines && !hasFocus)
              MTListTile(
                minHeight: expandButtonHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 0.7],
                    colors: [b2Color.resolve(context).withAlpha(0), b3Color.resolve(context)],
                  ),
                ),
                middle: UnconstrainedBox(
                  child: CaretIcon(
                    up: expanded,
                    color: mainColor,
                    size: const Size(P2, P),
                  ),
                ),
                padding: EdgeInsets.zero,
                bottomDivider: false,
                onTap: () => setState(() => expanded = !expanded),
              ),
          ],
        );
      });
    });
  }
}
