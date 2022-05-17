// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
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
      child: child ?? NormalText(title ?? '', color: titleColor ?? mainColor),
    );
  }
}
