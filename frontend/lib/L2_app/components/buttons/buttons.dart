// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../colors.dart';

enum ButtonType { primary, secondary }

class Button extends StatelessWidget {
  const Button(this.title, this.onPressed, {this.child, this.color, this.type, this.titleColor, this.padding, this.icon, this.margin});

  const Button.primary(this.title, this.onPressed, {this.child, this.titleColor, this.padding, this.margin})
      : type = ButtonType.primary,
        icon = null,
        color = null;

  const Button.icon(this.icon, this.onPressed, {this.color, this.type, this.padding})
      : title = null,
        child = icon,
        titleColor = null,
        margin = EdgeInsets.zero;

  final String? title;
  final VoidCallback? onPressed;
  final Widget? child;
  final Icon? icon;
  final ButtonType? type;
  final CupertinoDynamicColor? color;
  final CupertinoDynamicColor? titleColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: CupertinoButton(
        padding: padding ?? EdgeInsets.zero,
        onPressed: onPressed,
        color: type == ButtonType.primary ? CupertinoTheme.of(context).primaryColor : color,
        disabledColor: greyColor5(context),
        child: child ?? Text(title ?? '', style: TextStyle(color: onPressed != null ? titleColor : CupertinoColors.systemGrey)),
      ),
    );
  }
}
