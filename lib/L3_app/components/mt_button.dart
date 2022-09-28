// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'mt_rounded_container.dart';
import 'text_widgets.dart';

//TODO: решить вопрос в UIKit по кнопкам. После чего добавить сюда все варианты кнопок

class MTButton extends StatelessWidget {
  const MTButton({this.titleString, this.onTap, this.middle, this.color, this.titleColor, this.padding});

  final String? titleString;
  final VoidCallback? onTap;
  final Widget? middle;
  final Color? color;
  final Color? titleColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: padding ?? EdgeInsets.zero,
      onPressed: onTap,
      color: color,
      disabledColor: darkBackgroundColor,
      child: middle ?? MediumText(titleString ?? '', color: titleColor ?? mainColor),
    );
  }
}

class MTRoundedButton extends StatelessWidget {
  const MTRoundedButton({
    required this.onTap,
    this.titleString,
    this.topHint,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.borderColor,
    this.padding,
    this.elevation = 0,
    this.expanded = false,
    this.bordered = false,
  }) : assert((titleString == null && middle != null) || (titleString != null && middle == null));

  final String? titleString;
  final VoidCallback? onTap;

  final Widget? topHint;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;

  final Color? color;
  final Color? titleColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final bool expanded;
  final bool bordered;
  final double? elevation;

  Widget get child => middle ?? MediumText(titleString!, color: titleColor ?? darkGreyColor, align: TextAlign.center);

  @override
  Widget build(BuildContext context) {
    final radius = bordered ? onePadding * 2 : 0.0;

    return material(InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: MTRoundedContainer(
        padding: padding ?? EdgeInsets.all(onePadding / 2),
        borderRadius: radius,
        border: bordered ? Border.all(color: mainColor.resolve(context), width: 2) : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (topHint != null) ...[
              topHint!,
              SizedBox(height: onePadding / 2),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null) ...[leading!, SizedBox(width: onePadding / 2)],
                expanded ? Expanded(child: child) : child,
                if (trailing != null) ...[SizedBox(width: onePadding / 2), trailing!],
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class MTButtonIcon extends StatelessWidget {
  const MTButtonIcon(this.icon, this.onTap, {this.padding});
  final Widget icon;
  final VoidCallback? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => MTButton(middle: icon, onTap: onTap, padding: padding);
}
