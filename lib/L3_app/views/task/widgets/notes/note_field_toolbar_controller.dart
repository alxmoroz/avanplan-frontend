// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../components/constants.dart';
import '../../../../components/toolbar_controller.dart';
import '../../../../theme/text.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/task_view_controller.dart';

part 'note_field_toolbar_controller.g.dart';

class NFToolbarController extends _Base with _$NFToolbarController {
  NFToolbarController(this._tc, this._tvc);

  final TaskController _tc;
  final TaskViewController _tvc;

  static final int _fIndex = TaskFCode.note.index;
  String get _text => _tc.fData(_fIndex).text;

  final topPadding = P2;
  int? maxLines;
  bool ignoreBottomInsets = false;

  double _prefLineHeight(TextStyle style, [int? maxLines]) => TextPainter(
        text: TextSpan(text: '', style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      ).preferredLineHeight;

  double _footerHeight(BuildContext context) {
    final hasAttachments = _tc.attachmentsController.selectedFiles.isNotEmpty;
    final hasKB = MediaQuery.viewInsetsOf(context).bottom > 0;
    final bottomPadding = !ignoreBottomInsets && hasKB ? P2 : 0;
    final style = const SmallText('', maxLines: 1).style(context);
    return bottomPadding + (hasAttachments ? P + _prefLineHeight(style, 1) : 0.0);
  }

  int _maxLines(BuildContext context, double fh) {
    final kbHeight = MediaQuery.viewInsetsOf(context).bottom;
    final viewPadding = MediaQuery.paddingOf(context);
    final maxHeight = _tvc.centerConstraints.maxHeight -
        fh -
        topPadding -
        (ignoreBottomInsets ? P4 : (P12 + kbHeight + (kbHeight > 0 ? viewPadding.top : viewPadding.vertical)));

    return maxHeight ~/ _prefLineHeight(const BaseText('').style(context));
  }

  double _extraHeight(BuildContext context) {
    final fh = _footerHeight(context);
    maxLines = _maxLines(context, fh);
    final style = const BaseText('').style(context);
    final tp = TextPainter(
      text: TextSpan(text: _text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: _tvc.centerConstraints.maxWidth - (DEF_TAPPABLE_ICON_SIZE * 2 + P2 * 5 + P_2));

    final eh = tp.height - tp.preferredLineHeight + fh;
    return eh;
  }

  void calculateHeight(BuildContext context, {bool ignoreBottomInsets = false}) {
    this.ignoreBottomInsets = ignoreBottomInsets;
    setHeight(P8 + _extraHeight(context) + topPadding);
  }
}

abstract class _Base extends MTToolbarController with Store {}
