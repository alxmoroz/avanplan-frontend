// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../../L2_data/services/platform.dart';
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
import '../../../../presenters/task_actions.dart';
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
  bool expanded = false;

  static final readOnlyMaxLines = isWeb ? 15 : 10;
  static const expandButtonHeight = P6;

  bool get _hasFocus => fNode?.hasFocus == true;

  void _fNodeListener() => setState(() {
        if (_hasFocus) expanded = true;
      });

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

  bool _exceedROMaxLines(double maxWidth) {
    final tp = TextPainter(text: TextSpan(text: fd.text), maxLines: readOnlyMaxLines, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: maxWidth - (widget.padding?.horizontal ?? 0));
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, size) {
      return Observer(builder: (_) {
        final hasFocus = _hasFocus;
        bool exceedROMaxLines = false;
        int? maxLines;
        final needCheckToggle = !hasFocus && task.isTask;
        if (needCheckToggle) {
          exceedROMaxLines = _exceedROMaxLines(size.maxWidth);
          maxLines = hasFocus || expanded ? null : readOnlyMaxLines;
        }
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MTField(
              fd,
              color: Colors.transparent,
              padding: (widget.padding ?? EdgeInsets.zero),
              value: MTTextFieldInline(
                teController,
                key: widget.key,
                maxLines: maxLines,
                fNode: fNode,
                readOnly: !task.canEdit,
                autofocus: widget.standalone && !task.hasDescription,
                hintText: hintText,
                style: BaseText('', color: widget.standalone ? null : f2Color, maxLines: maxLines).style(context),
                onChanged: controller.setDescription,
                onTap: () => fNode?.requestFocus(),
              ),
              // onTap: () => fNode?.requestFocus(),
            ),
            if (exceedROMaxLines && !hasFocus)
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
