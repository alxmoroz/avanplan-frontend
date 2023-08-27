// Copyright (c) 2022. Alexandr Moroz

import 'dart:ui';

import 'package:flutter/material.dart';

import 'adaptive.dart';
import 'close_dialog_button.dart';
import 'colors.dart';
import 'constants.dart';
import 'text.dart';

class MTTopBar extends StatelessWidget {
  const MTTopBar({
    this.titleText,
    this.leading,
    this.middle,
    this.trailing,
    this.showCloseButton = true,
    this.onClose,
  });
  final String? titleText;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final bool showCloseButton;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        if (middle != null || titleText != null)
          Padding(padding: const EdgeInsets.only(top: P), child: middle ?? MediumText(titleText!, align: TextAlign.center)),
        Row(children: [
          if (leading != null || showCloseButton) leading ?? MTCloseDialogButton(onTap: onClose),
          const Spacer(),
          if (trailing != null) trailing!,
        ]),
      ],
    );
  }
}

class MTToolbar extends StatelessWidget {
  const MTToolbar({required this.child, required this.color, this.top = false});
  const MTToolbar.top({required this.child, required this.color}) : top = true;

  final Widget child;
  final Color color;
  final bool top;

  @override
  Widget build(BuildContext context) {
    final bPadding = top ? 0.0 : bottomPadding(context);
    final topPadding = top ? 0.0 : P;

    final inner = Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bPadding,
      ),
      child: child,
    );

    return Container(
      color: color.resolve(context),
      child: color.opacity == 1
          ? inner
          : ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: inner,
              ),
            ),
    );
  }
}
