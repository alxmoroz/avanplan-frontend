// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../controllers/task_controller.dart';
import '../notes/note_field.dart';

class NoteFieldToolbar extends StatelessWidget implements PreferredSizeWidget {
  const NoteFieldToolbar(this._controller, {super.key, this.extraHeight = 0.0, this.inDialog = false});
  final TaskController _controller;
  final double extraHeight;
  final bool inDialog;

  static int maxLines(BuildContext context) {
    final mq = MediaQuery.of(context);
    final innerHeight = mq.size.height - mq.padding.vertical - mq.viewInsets.vertical;
    return innerHeight > SCR_M_HEIGHT ? 20 : 10;
  }

  static double calculateExtraHeight(BuildContext context, TaskController controller) {
    final ml = maxLines(context);
    final style = BaseText('', maxLines: ml).style(context);
    final tp = TextPainter(
      text: TextSpan(text: controller.fData(TaskFCode.note.index).text, style: style),
      maxLines: ml,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: MediaQuery.sizeOf(context).width - 141);

    final oneLineHeight = style.fontSize ?? 0;
    final hasAttachments = controller.attachmentsController.selectedFiles.isNotEmpty;
    final footerHeight = (hasAttachments ? P + (const SmallText('', maxLines: 1).style(context).fontSize ?? 0.0) : 0.0);
    final extra = tp.height - oneLineHeight;
    return (extra >= oneLineHeight ? extra : 0.0) + footerHeight;
  }

  double get _bottomPadding => P2;
  double get _topPadding => P2;
  double get _verticalPadding => _topPadding + _bottomPadding;

  @override
  Size get preferredSize => Size.fromHeight(P8 + extraHeight + _verticalPadding);

  @override
  Widget build(BuildContext context) {
    return MTAppBar(
      key: const ValueKey('NoteFieldToolbar'),
      isBottom: true,
      color: b2Color,
      inDialog: inDialog,
      innerHeight: preferredSize.height - _verticalPadding,
      padding: EdgeInsets.only(top: _topPadding, bottom: _bottomPadding),
      middle: NoteField(_controller, standalone: true, maxLines: maxLines(context)),
    );
  }
}
