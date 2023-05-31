// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';
import 'mt_constrained.dart';
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
    this.maxWidth,
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
    this.maxWidth,
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
    this.maxWidth,
  }) : type = ButtonType.secondary;

  const MTButton.icon(Widget icon, this.onTap, {this.margin, this.padding})
      : type = ButtonType.icon,
        middle = icon,
        titleText = null,
        color = null,
        leading = null,
        trailing = null,
        titleColor = null,
        maxWidth = 0,
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
  final double? maxWidth;

  Color get _titleColor => onTap != null ? (titleColor ?? (type == ButtonType.main ? lightBackgroundColor : mainColor)) : greyColor;
  Color get _btnColor => onTap != null ? (color ?? (type == ButtonType.main ? mainColor : lightBackgroundColor)) : borderColor;
  ButtonStyle _style(BuildContext context) => ElevatedButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        backgroundColor: _btnColor.resolve(context),
        disabledBackgroundColor: _btnColor.resolve(context),
        foregroundColor: _titleColor.resolve(context),
        minimumSize: const Size(MIN_BTN_HEIGHT, MIN_BTN_HEIGHT),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BTN_BORDER_RADIUS)),
        side: type == ButtonType.secondary ? BorderSide(color: _titleColor.resolve(context), width: 1) : BorderSide.none,
        splashFactory: NoSplash.splashFactory,
        visualDensity: VisualDensity.standard,
        shadowColor: (type == ButtonType.main ? _btnColor : _titleColor).resolve(context),
        elevation: 2,
      );

  Widget get _middle => middle ?? MediumText(titleText ?? '', color: _titleColor);
  Widget get _child => _MTBaseLayout(leading: leading, middle: _middle, trailing: trailing);

  Widget _button(BuildContext context) {
    switch (type) {
      case ButtonType.main:
      case ButtonType.secondary:
        return OutlinedButton(onPressed: onTap, style: _style(context), child: _child, clipBehavior: Clip.antiAlias);
      default:
        return CupertinoButton(onPressed: onTap, child: _child, minSize: 0, padding: padding ?? EdgeInsets.zero, color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    final btn = Padding(padding: margin ?? EdgeInsets.zero, child: _button(context));
    return constrained ? MTConstrained(btn, maxWidth: maxWidth) : btn;
  }
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
        if (leading != null) ...[leading!, const SizedBox(width: P_3)],
        middle,
        if (trailing != null) ...[const SizedBox(width: P_3), trailing!],
      ],
    );
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
      constrained: false,
      middle: PlusIcon(color: type == ButtonType.main ? lightBackgroundColor : mainColor),
      margin: const EdgeInsets.only(right: P),
      onTap: onTap,
    );
  }
}
