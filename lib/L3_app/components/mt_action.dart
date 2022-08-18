// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_button.dart';
import 'text_widgets.dart';

class MTFloatingAction extends StatelessWidget {
  const MTFloatingAction({
    this.hint = '',
    this.title,
    this.onPressed,
    this.hintColor,
    this.icon,
  });

  final String hint;
  final VoidCallback? onPressed;
  final String? title;
  final Color? hintColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hint.isNotEmpty) MediumText(hint, align: TextAlign.center, color: hintColor ?? lightGreyColor),
          if (title != null) ...[
            if (hint.isNotEmpty) SizedBox(height: onePadding / 2),
            MTButton(
              null,
              onPressed,
              child: Row(
                children: [
                  const Spacer(),
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: onePadding / 2),
                  ],
                  H4(title!, color: mainColor),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
