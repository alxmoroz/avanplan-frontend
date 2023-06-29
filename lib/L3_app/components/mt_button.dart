// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';
import 'mt_adaptive.dart';
import 'text_widgets.dart';

enum ButtonType { text, main, secondary, icon }

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
    this.constrained = false,
    this.type = ButtonType.text,
  });

  const MTButton.main({
    this.titleText,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.constrained = true,
    this.padding,
    this.margin,
  }) : type = ButtonType.main;

  const MTButton.secondary({
    this.titleText,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.constrained = true,
    this.padding,
    this.margin,
  }) : type = ButtonType.secondary;

  const MTButton.icon(Widget icon, this.onTap, {this.margin, this.padding, this.color})
      : type = ButtonType.icon,
        middle = icon,
        titleText = null,
        leading = null,
        trailing = null,
        titleColor = null,
        constrained = false;

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
  final bool constrained;

  Color get _titleColor => onTap != null ? (titleColor ?? (type == ButtonType.main ? lightBackgroundColor : mainColor)) : greyTextColor;

  ButtonStyle _style(BuildContext context) {
    final _btnColor = (onTap != null ? (color ?? (type == ButtonType.main ? mainColor : lightBackgroundColor)) : borderColor).resolve(context);

    return ElevatedButton.styleFrom(
      padding: padding ?? EdgeInsets.zero,
      foregroundColor: _titleColor.resolve(context),
      backgroundColor: _btnColor,
      disabledForegroundColor: _btnColor,
      disabledBackgroundColor: _btnColor,
      minimumSize: const Size(MIN_BTN_HEIGHT, MIN_BTN_HEIGHT),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BTN_BORDER_RADIUS)),
      side: type == ButtonType.secondary ? BorderSide(color: _titleColor.resolve(context), width: 1) : BorderSide.none,
      splashFactory: NoSplash.splashFactory,
      visualDensity: VisualDensity.standard,
      shadowColor: (type == ButtonType.main ? _btnColor : _titleColor).resolve(context),
      elevation: buttonElevation,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _button(BuildContext context) {
    final _child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: P_3)],
        middle ?? (titleText != null ? MediumText(titleText!, color: _titleColor) : Container()),
        if (trailing != null) ...[const SizedBox(width: P_3), trailing!],
      ],
    );

    switch (type) {
      case ButtonType.main:
      case ButtonType.secondary:
        return OutlinedButton(onPressed: onTap, child: _child, style: _style(context), clipBehavior: Clip.hardEdge);
      default:
        return CupertinoButton(onPressed: onTap, child: _child, minSize: 0, padding: padding ?? EdgeInsets.zero, color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    final btn = Padding(padding: margin ?? EdgeInsets.zero, child: _button(context));
    return type == ButtonType.icon || !constrained ? btn : MTAdaptive.XS(btn);
  }
}

class MTPlusButton extends StatelessWidget {
  const MTPlusButton(this.onTap, {this.type = ButtonType.main});
  final VoidCallback? onTap;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    return MTButton(
      type: type,
      middle: PlusIcon(color: type == ButtonType.main ? lightBackgroundColor : mainColor),
      margin: const EdgeInsets.only(right: P),
      onTap: onTap,
    );
  }
}
