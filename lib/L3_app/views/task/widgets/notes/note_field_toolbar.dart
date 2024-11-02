// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/task_view_controller.dart';
import '../notes/note_field.dart';

class NoteFieldToolbar extends StatelessWidget implements PreferredSizeWidget {
  const NoteFieldToolbar(
    this._tc,
    this._tvController, {
    super.key,
    this.extraHeight = 0.0,
    this.ignoreBottomInsets = false,
  });
  final TaskController _tc;
  final TaskViewController _tvController;
  final double extraHeight;
  final bool ignoreBottomInsets;

  static const _topPadding = P2;

  @override
  Size get preferredSize => Size.fromHeight(P8 + extraHeight + _topPadding);

  static double _prefLineHeight(BuildContext context, TextStyle style) => TextPainter(
        text: TextSpan(text: '', style: style),
        textDirection: TextDirection.ltr,
      ).preferredLineHeight;

  static double _footerHeight(BuildContext context, TaskController tc, bool ignoreBottomInsets) {
    final hasAttachments = tc.attachmentsController.selectedFiles.isNotEmpty;
    return hasAttachments ? P + _prefLineHeight(context, const SmallText('', maxLines: 1).style(context)) : 0.0;
  }

  static double _extraPadding(BuildContext context, bool ignoreBottomInsets) =>
      !ignoreBottomInsets && MediaQuery.viewInsetsOf(context).bottom > 0 ? P2 : 0;

  static int _maxLines(BuildContext context, TaskController tc, TaskViewController tvc, bool ignoreBottomInsets) {
    final viewInsets = MediaQuery.viewInsetsOf(context).bottom;
    final viewPadding = MediaQuery.paddingOf(context);
    final maxHeight = tvc.centerConstraints.maxHeight -
        _footerHeight(context, tc, ignoreBottomInsets) -
        _topPadding -
        (ignoreBottomInsets ? P4 : (P12 + viewInsets + (viewInsets > 0 ? viewPadding.top : viewPadding.vertical)));
    return maxHeight ~/ _prefLineHeight(context, const BaseText('').style(context));
  }

  static double calculateExtraHeight(BuildContext context, TaskController tc, TaskViewController tvController, bool ignoreBottomInsets) {
    final ml = _maxLines(context, tc, tvController, ignoreBottomInsets);
    final style = const BaseText('').style(context);
    final tp = TextPainter(
      text: TextSpan(text: tc.fData(TaskFCode.note.index).text, style: style),
      maxLines: ml,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: tvController.centerConstraints.maxWidth - 141);

    return tp.height - tp.preferredLineHeight + _footerHeight(context, tc, ignoreBottomInsets) + _extraPadding(context, ignoreBottomInsets);
  }

  @override
  Widget build(BuildContext context) {
    final innerHeight = preferredSize.height - _topPadding;
    return MTBottomBar(
      key: const ValueKey('NoteFieldToolbar'),
      ignoreBottomInsets: ignoreBottomInsets,
      innerHeight: innerHeight,
      topPadding: _topPadding,
      middle: NoteField(
        _tc,
        maxLines: _maxLines(context, _tc, _tvController, ignoreBottomInsets),
      ),
    );
  }
}
