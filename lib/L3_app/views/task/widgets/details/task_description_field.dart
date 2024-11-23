// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field_inline.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';

class TaskDescriptionField extends StatefulWidget {
  const TaskDescriptionField(this._tc, {super.key, this.standalone = false, this.padding});
  final TaskController _tc;
  final bool standalone;
  final EdgeInsets? padding;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TaskDescriptionField> {
  static final _fIndex = TaskFCode.description.index;
  static final _readOnlyMaxLines = isWeb ? 15 : 7;
  static const _expandButtonHeight = P6;

  TaskController get _tc => widget._tc;
  Task get _t => _tc.task;
  TextEditingController get _teController => _tc.teController(_fIndex)!;
  MTFieldData get _fd => _tc.fData(_fIndex);

  FocusNode? _fNode;
  bool _expanded = false;
  bool get _hasFocus => _fNode?.hasFocus == true;

  void _fNodeListener() => setState(() {
        if (_hasFocus) _expanded = true;
      });

  @override
  void initState() {
    if (_tc.canEdit) {
      _fNode = _tc.focusNode(_fIndex);
      _fNode?.addListener(_fNodeListener);
    }
    super.initState();
  }

  @override
  void dispose() {
    _fNode?.removeListener(_fNodeListener);
    super.dispose();
  }

  bool _exceedROMaxLines(double maxWidth) {
    final tp = TextPainter(text: TextSpan(text: _fd.text), maxLines: _readOnlyMaxLines, textDirection: TextDirection.ltr);
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
        final needCheckToggle = !hasFocus && _t.isTask;
        if (needCheckToggle) {
          exceedROMaxLines = _exceedROMaxLines(size.maxWidth);
          maxLines = hasFocus || _expanded ? null : _readOnlyMaxLines;
        }
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MTField(
              _fd,
              color: Colors.transparent,
              padding: (widget.padding ?? EdgeInsets.zero),
              value: MTTextFieldInline(
                _teController,
                key: widget.key,
                maxLines: maxLines,
                fNode: _fNode,
                readOnly: !_tc.canEdit,
                paddingLines: exceedROMaxLines ? 1 : 0,
                autofocus: widget.standalone && !_t.hasDescription,
                hintText: loc.description,
                style: BaseText('', color: widget.standalone ? null : f2Color, maxLines: maxLines).style(context),
                onChanged: _tc.setDescription,
                onTap: () => _fNode?.requestFocus(),
              ),
              // onTap: () => fNode?.requestFocus(),
            ),
            if (exceedROMaxLines && !hasFocus)
              MTListTile(
                minHeight: _expandButtonHeight,
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
                    up: _expanded,
                    color: mainColor,
                    size: const Size(P2, P),
                  ),
                ),
                padding: EdgeInsets.zero,
                bottomDivider: false,
                onTap: () => setState(() => _expanded = !_expanded),
              ),
          ],
        );
      });
    });
  }
}
