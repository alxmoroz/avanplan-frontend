// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';
import 'text_widgets.dart';

//TODO: решить вопрос в UIKit по кнопкам. После чего добавить сюда все варианты кнопок

enum ButtonType { text, elevated, outlined, icon }

class MTButton extends StatelessWidget {
  const MTButton({
    this.titleText,
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
    this.titleText,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    EdgeInsets? padding,
    this.margin,
  })  : type = ButtonType.outlined,
        padding = padding ?? EdgeInsets.symmetric(horizontal: onePadding);

  const MTButton.icon(Widget icon, this.onTap, {this.margin, this.padding})
      : type = ButtonType.icon,
        middle = icon,
        titleText = null,
        color = null,
        leading = null,
        trailing = null,
        titleColor = null;

  final ButtonType type;
  final String? titleText;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Color? color;
  final Color? titleColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  Color get _titleColor => onTap != null ? (titleColor ?? mainColor) : lightGreyColor;
  double get _minWidth => minButtonHeight;

  ButtonStyle _style(BuildContext context) => ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        backgroundColor: (color ?? Colors.transparent).resolve(context),
        // surfaceTintColor: _titleColor.resolve(context),
        foregroundColor: _titleColor.resolve(context),
        minimumSize: Size(_minWidth, minButtonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
        side: type == ButtonType.outlined ? BorderSide(color: _titleColor.resolve(context), width: 2) : null,
        splashFactory: NoSplash.splashFactory,
      );

  Widget get _middle => middle ?? MediumText(titleText ?? '', color: _titleColor);
  Widget get _child => _MTBaseLayout(leading: leading, middle: _middle, trailing: trailing);

  Widget _button(BuildContext context) {
    switch (type) {
      case ButtonType.elevated:
        return ElevatedButton(onPressed: onTap, style: _style(context), child: _child);
      case ButtonType.outlined:
        return OutlinedButton(onPressed: onTap, style: _style(context), child: _child);
      default:
        return CupertinoButton(onPressed: onTap, child: _child, minSize: 0, padding: padding ?? EdgeInsets.zero, color: color);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(padding: margin ?? EdgeInsets.zero, child: _button(context));
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
        if (leading != null) ...[leading!, SizedBox(width: onePadding / 3)],
        middle,
        if (trailing != null) ...[SizedBox(width: onePadding / 3), trailing!],
      ],
    );
  }
}

class MTPlusButton extends StatelessWidget {
  const MTPlusButton(this.onTap);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MTButton.outlined(
      middle: PlusIcon(size: onePadding * 2),
      margin: EdgeInsets.only(right: onePadding),
      onTap: onTap,
    );
  }
}
