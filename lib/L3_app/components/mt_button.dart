// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_widgets.dart';

//TODO: решить вопрос в UIKit по кнопкам. После чего добавить сюда все варианты кнопок

enum ButtonType { text, elevated, outlined, icon }

class MTButton extends StatelessWidget {
  const MTButton({
    this.titleString,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.padding,
    this.margin,
  }) : type = ButtonType.text;

  MTButton.outlined({
    this.titleString,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    EdgeInsets? padding,
    this.margin,
  })  : type = ButtonType.outlined,
        padding = padding ?? EdgeInsets.all(onePadding);

  const MTButton.icon(Widget icon, this.onTap, {this.margin, this.padding})
      : type = ButtonType.icon,
        middle = icon,
        titleString = null,
        color = null,
        leading = null,
        trailing = null,
        titleColor = null;

  final ButtonType type;
  final String? titleString;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Color? color;
  final Color? titleColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  ButtonStyle get _style => ElevatedButton.styleFrom(
      padding: padding ?? EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      minimumSize: Size.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
      side: type == ButtonType.outlined ? const BorderSide(color: mainColor, width: 2) : null,
      splashFactory: NoSplash.splashFactory);

  Widget get _middle => middle ?? MediumText(titleString ?? '', color: onTap != null ? (titleColor ?? mainColor) : lightGreyColor);
  Widget get _child => _MTBaseLayout(leading: leading, middle: _middle, trailing: trailing);

  Widget get _button {
    switch (type) {
      case ButtonType.elevated:
        return ElevatedButton(onPressed: onTap, style: _style, child: _child);
      case ButtonType.outlined:
        return OutlinedButton(onPressed: onTap, style: _style, child: _child);
      default:
        return CupertinoButton(onPressed: onTap, child: _child, minSize: 0, padding: EdgeInsets.zero);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(padding: margin ?? EdgeInsets.zero, child: _button);
}

class _MTBaseLayout extends StatelessWidget {
  const _MTBaseLayout({
    required this.middle,
    this.leading,
    this.trailing,
  });

  final Widget middle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, SizedBox(width: onePadding / 2)],
        middle,
        if (trailing != null) ...[SizedBox(width: onePadding / 2), trailing!],
      ],
    );
  }
}
