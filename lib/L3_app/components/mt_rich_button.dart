// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_card.dart';
import 'text_widgets.dart';

class MTRichButton extends StatelessWidget {
  const MTRichButton({
    this.hint = '',
    this.title,
    this.onTap,
    this.hintColor,
    this.icon,
    this.elevation,
  });

  final String hint;
  final VoidCallback? onTap;
  final String? title;
  final Color? hintColor;
  final Widget? icon;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MTCard(
        onTap: onTap,
        elevation: elevation,
        padding: EdgeInsets.all(onePadding),
        body: Column(
          children: [
            if (hint.isNotEmpty) MediumText(hint, align: TextAlign.center, color: hintColor ?? lightGreyColor),
            if (title != null) ...[
              if (hint.isNotEmpty) SizedBox(height: onePadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: onePadding / 2),
                  ],
                  H4(title!, color: mainColor),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
