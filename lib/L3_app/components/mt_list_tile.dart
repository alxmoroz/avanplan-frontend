// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_widgets.dart';

class MTListTile extends StatelessWidget {
  const MTListTile({
    this.leading,
    this.middle,
    this.subtitle,
    this.titleText,
    this.trailing,
    this.onTap,
    this.topBorder = false,
    this.bottomBorder = true,
  });
  final Widget? leading;
  final Widget? middle;
  final Widget? subtitle;
  final String? titleText;
  final Widget? trailing;
  final Function()? onTap;
  final bool topBorder;
  final bool bottomBorder;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(onePadding),
          decoration: BoxDecoration(
            border: Border(
              top: topBorder ? BorderSide(width: 0.5, color: borderColor.resolve(context)) : BorderSide.none,
              bottom: bottomBorder ? BorderSide(width: 0.5, color: borderColor.resolve(context)) : BorderSide.none,
            ),
          ),
          child: Row(
            children: [
              if (leading != null) ...[leading!, SizedBox(width: onePadding / 2)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (middle != null || titleText != null) middle ?? (titleText != null ? NormalText(titleText!) : Container()),
                    if (subtitle != null) subtitle!,
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      );
}
