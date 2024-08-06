// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field_inline.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';

class TaskDescriptionField extends StatefulWidget {
  const TaskDescriptionField(this._controller, {super.key});
  final TaskController _controller;
  @override
  State<StatefulWidget> createState() => _TaskDescriptionFieldState();
}

class _TaskDescriptionFieldState extends State<TaskDescriptionField> {
  TaskController get controller => widget._controller;
  Task get task => controller.task;
  TextEditingController get teController => controller.teController(fIndex)!;
  FocusNode? get fNode => controller.focusNode(fIndex);

  final hintText = loc.description;
  final fIndex = TaskFCode.description.index;

  bool expanded = true;

  void editText(String str) {
    controller.setDescription(str);
    setState(() {});
  }

  void tap() {
    if (task.canEdit) {
      controller.setFocus(fIndex);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const readOnlyMaxLines = 15;
  static const readOnlyShortLines = 7;
  static const expandButtonHeight = P6;

  bool _exceedROMaxLines(BuildContext context) {
    final tp = TextPainter(text: TextSpan(text: teController.text), maxLines: readOnlyMaxLines, textDirection: TextDirection.ltr);
    tp.layout(maxWidth: MediaQuery.of(context).size.width);
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final exceedReadOnlyMaxLines = _exceedROMaxLines(context);
      fNode?.addListener(() => setState(() {}));
      final hasFocus = fNode?.hasFocus == true;
      final maxLines = hasFocus || expanded ? null : readOnlyShortLines;
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTField(
            controller.fData(fIndex),
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(
              bottom: exceedReadOnlyMaxLines && expanded && !hasFocus ? expandButtonHeight : 0,
            ),
            value: MTTextFieldInline(
              teController,
              maxLines: maxLines,
              fNode: fNode,
              hintText: hintText,
              style: const BaseText('', color: f2Color).style(context),
              onChanged: editText,
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
  }
}
