// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'icons.dart';
import 'mt_adaptive.dart';
import 'mt_card.dart';
import 'text_widgets.dart';

enum ButtonType { text, main, secondary, icon, card }

class MTButton extends StatelessWidget {
  const MTButton({
    this.titleText,
    this.onTap,
    this.onLongPress,
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
    this.onLongPress,
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
    this.onLongPress,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.constrained = true,
    this.padding,
    this.margin,
  }) : type = ButtonType.secondary;

  const MTButton.icon(Widget icon, this.onTap, {this.margin, this.padding, this.color, this.onLongPress})
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
  final VoidCallback? onLongPress;
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(type == ButtonType.card ? DEF_BORDER_RADIUS : DEF_BTN_BORDER_RADIUS)),
      side: type == ButtonType.secondary ? BorderSide(color: _titleColor.resolve(context), width: 1) : BorderSide.none,
      splashFactory: NoSplash.splashFactory,
      visualDensity: VisualDensity.standard,
      shadowColor: (type == ButtonType.secondary ? _titleColor : _btnColor).resolve(context),
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
      case ButtonType.card:
        return OutlinedButton(
          onPressed: onTap,
          onLongPress: onLongPress,
          child: _child,
          style: _style(context),
          clipBehavior: Clip.hardEdge,
        );
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

class MTCardButton extends StatelessWidget {
  const MTCardButton({required this.child, this.margin, this.onTap, this.onLongPress, this.elevation, this.radius, this.padding, this.color});

  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? elevation;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MTButton(
      type: ButtonType.card,
      constrained: false,
      margin: margin ?? EdgeInsets.zero,
      onTap: onTap,
      onLongPress: onLongPress,
      middle: Expanded(
        child: MTCard(
          child: child,
          elevation: elevation,
          radius: radius,
          padding: padding ?? const EdgeInsets.all(P),
          color: color,
        ),
      ),
    );
  }
}
