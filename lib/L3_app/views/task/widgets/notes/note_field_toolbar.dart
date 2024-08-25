// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/task_view_controller.dart';
import '../notes/note_field.dart';

class NoteFieldToolbar extends StatelessWidget implements PreferredSizeWidget {
  const NoteFieldToolbar(this._controller, this._tvController, {super.key, this.extraHeight = 0.0, this.inDialog = false});
  final TaskController _controller;
  final TaskViewController _tvController;
  final double extraHeight;
  final bool inDialog;

  static double _footerHeight(BuildContext context, TaskController controller) {
    final hasAttachments = controller.attachmentsController.selectedFiles.isNotEmpty;
    return (hasAttachments ? P + (const SmallText('', maxLines: 1).style(context).fontSize ?? 0.0) : 0.0);
  }

  static int _maxLines(BuildContext context, TaskController controller, TaskViewController tvController, bool inDialog) {
    final viewInsets = MediaQuery.viewInsetsOf(context).bottom;
    final viewPadding = MediaQuery.paddingOf(context);
    final maxHeight = tvController.centerConstraints.maxHeight -
        _footerHeight(context, controller) -
        _verticalPadding -
        (inDialog ? P4 : (P12 + viewInsets + (viewInsets > 0 ? viewPadding.top : viewPadding.vertical)));
    return maxHeight ~/
        TextPainter(
          text: TextSpan(text: '', style: const BaseText('').style(context)),
          textDirection: TextDirection.ltr,
        ).preferredLineHeight;
  }

  static double calculateExtraHeight(BuildContext context, TaskController controller, TaskViewController tvController, bool inDialog) {
    final ml = _maxLines(context, controller, tvController, inDialog);
    final style = const BaseText('').style(context);
    final tp = TextPainter(
      text: TextSpan(text: controller.fData(TaskFCode.note.index).text, style: style),
      maxLines: ml,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: tvController.centerConstraints.maxWidth - 141);

    return tp.height - tp.preferredLineHeight + _footerHeight(context, controller);
  }

  static const _bottomPadding = P2;
  static const _topPadding = P2;
  static const _verticalPadding = _topPadding + _bottomPadding;

  @override
  Size get preferredSize => Size.fromHeight(P8 + extraHeight + _verticalPadding);

  double get innerHeight => preferredSize.height - _verticalPadding;

  @override
  Widget build(BuildContext context) {
    return MTAppBar(
      key: const ValueKey('NoteFieldToolbar'),
      isBottom: true,
      color: b2Color,
      inDialog: inDialog,
      innerHeight: innerHeight,
      padding: const EdgeInsets.only(top: _topPadding, bottom: _bottomPadding),
      middle: NoteField(_controller, standalone: true, maxLines: _maxLines(context, _controller, _tvController, inDialog)),
    );
  }
}
