// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_card.dart';
import 'text_widgets.dart';

class MTButton extends StatelessWidget {
  const MTButton(this.title, this.onPressed, {this.child, this.color, this.titleColor, this.padding, this.icon});

  const MTButton.icon(this.icon, this.onPressed, {this.color, this.padding})
      : title = null,
        child = icon,
        titleColor = null;

  final String? title;
  final VoidCallback? onPressed;
  final Widget? child;
  final Widget? icon;
  final Color? color;
  final Color? titleColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: padding ?? EdgeInsets.zero,
      onPressed: onPressed,
      color: color,
      disabledColor: darkBackgroundColor,
      child: child ?? MediumText(title ?? '', color: titleColor ?? mainColor),
    );
  }
}

class MTRichButton extends StatelessWidget {
  const MTRichButton({
    this.hint = '',
    this.titleString,
    this.middle,
    this.onTap,
    this.hintColor,
    this.prefix,
    this.suffix,
    this.elevation,
    this.padding,
    this.bgColor,
    this.expanded = false,
  }) : assert((titleString == null && middle != null) || (titleString != null && middle == null));

  const MTRichButton.flat({
    this.hint = '',
    this.onTap,
    this.titleString,
    this.middle,
    this.hintColor,
    this.prefix,
    this.suffix,
    this.expanded = false,
  })  : elevation = 0,
        bgColor = backgroundColor,
        padding = EdgeInsets.zero;

  final String hint;
  final VoidCallback? onTap;
  final String? titleString;
  final Widget? middle;
  final Color? hintColor;
  final Widget? prefix;
  final Widget? suffix;
  final double? elevation;
  final EdgeInsets? padding;
  final Color? bgColor;
  final bool expanded;

  Widget get child => middle ?? MediumText(titleString!, color: darkGreyColor);

  @override
  Widget build(BuildContext context) {
    return MTCard(
      onTap: onTap,
      elevation: elevation,
      padding: padding ?? EdgeInsets.all(onePadding),
      bgColor: bgColor,
      body: Column(
        children: [
          if (hint.isNotEmpty) ...[
            MediumText(hint, align: TextAlign.center, color: hintColor ?? lightGreyColor),
            SizedBox(height: onePadding / 2),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefix != null) ...[prefix!, SizedBox(width: onePadding / 2)],
              expanded ? Expanded(child: child) : child,
              if (suffix != null) ...[SizedBox(width: onePadding / 2), suffix!],
            ],
          ),
        ],
      ),
    );
  }
}
