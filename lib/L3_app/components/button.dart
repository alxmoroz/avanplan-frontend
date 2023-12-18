// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adaptive.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'icons.dart';
import 'loader.dart';
import 'material_wrapper.dart';
import 'pay_badge.dart';
import 'text.dart';

enum ButtonType { text, main, secondary, icon, card }

enum FeedbackType { light, medium, heavy, vibrate, selection }

mixin FocusManaging {
  void unfocus(BuildContext context) {
    final fs = FocusScope.of(context);
    if (fs.hasFocus) {
      fs.unfocus();
    }
  }

  Future tapAction(BuildContext context, bool uf, Function callback, {FeedbackType? fbType}) async {
    if (fbType != null) {
      switch (fbType) {
        case FeedbackType.light:
          await HapticFeedback.lightImpact();
          break;
        case FeedbackType.medium:
          await SystemSound.play(SystemSoundType.click);
          await HapticFeedback.mediumImpact();
          break;
        case FeedbackType.heavy:
          await HapticFeedback.heavyImpact();
          break;
        case FeedbackType.vibrate:
          await HapticFeedback.vibrate();
          break;
        case FeedbackType.selection:
          await HapticFeedback.selectionClick();
          break;
      }
    }

    if (uf) {
      unfocus(context);
    }
    await callback();
  }
}

class MTButton extends StatelessWidget with FocusManaging {
  const MTButton({
    this.titleText,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.padding,
    this.margin,
    this.constrained = false,
    this.elevation,
    this.loading,
    this.type = ButtonType.text,
    this.uf = true,
    this.minSize,
  });

  const MTButton.main({
    this.titleText,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.constrained = true,
    this.padding,
    this.margin,
    this.elevation,
    this.loading,
    this.uf = true,
    this.minSize,
  }) : type = ButtonType.main;

  const MTButton.secondary({
    this.titleText,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.leading,
    this.middle,
    this.trailing,
    this.color,
    this.titleColor,
    this.constrained = true,
    this.padding,
    this.margin,
    this.elevation,
    this.loading,
    this.uf = true,
    this.minSize,
  }) : type = ButtonType.secondary;

  const MTButton.icon(
    Widget icon, {
    this.margin,
    this.padding,
    this.color,
    this.elevation,
    this.loading,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.uf = true,
    this.minSize,
  })  : type = ButtonType.icon,
        middle = icon,
        titleText = null,
        leading = null,
        trailing = null,
        titleColor = null,
        constrained = false;

  final ButtonType type;
  final String? titleText;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function(bool)? onHover;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;
  final Color? color;
  final Color? titleColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool constrained;
  final double? elevation;
  final bool? loading;
  final bool uf;
  final Size? minSize;

  bool get _enabled => loading != true && (onTap != null || onLongPress != null);
  bool get _custom => [ButtonType.card].contains(type);
  Color get _titleColor => _enabled || _custom ? (titleColor ?? (type == ButtonType.main ? mainBtnTitleColor : mainColor)) : f2Color;
  double get _radius => type == ButtonType.card ? DEF_BORDER_RADIUS : DEF_BTN_BORDER_RADIUS;

  ButtonStyle _style(BuildContext context) {
    final _btnColor = (_enabled || _custom ? (color ?? (type == ButtonType.main ? mainColor : b3Color)) : b1Color).resolve(context);

    return ElevatedButton.styleFrom(
      padding: padding ?? EdgeInsets.zero,
      foregroundColor: _titleColor.resolve(context),
      backgroundColor: _btnColor,
      disabledForegroundColor: _btnColor,
      disabledBackgroundColor: _btnColor,
      minimumSize: minSize ?? const Size(MIN_BTN_HEIGHT, MIN_BTN_HEIGHT),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
      side: type == ButtonType.secondary ? BorderSide(color: _titleColor.resolve(context), width: 1) : BorderSide.none,
      splashFactory: NoSplash.splashFactory,
      visualDensity: VisualDensity.standard,
      shadowColor: b0Color.resolve(context),
      elevation: elevation ?? buttonElevation,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _button(BuildContext context) {
    final _onPressed = _enabled && onTap != null ? () => tapAction(context, uf, onTap!, fbType: FeedbackType.light) : null;
    final _onLongPress = _enabled && onLongPress != null ? () => tapAction(context, uf, onLongPress!, fbType: FeedbackType.medium) : null;

    final _child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: P)],
        middle ?? (titleText != null ? BaseText.medium(titleText!, color: _titleColor, maxLines: 1) : Container()),
        if (trailing != null) ...[const SizedBox(width: P), trailing!],
      ],
    );

    switch (type) {
      case ButtonType.main:
      case ButtonType.secondary:
      case ButtonType.card:
        return OutlinedButton(
          onPressed: _onPressed,
          onLongPress: _onLongPress,
          onHover: onHover,
          child: _child,
          style: _style(context),
          clipBehavior: Clip.hardEdge,
        );
      default:
        return material(
          InkWell(
            onHover: onHover,
            onTap: onHover != null ? () {} : null,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            canRequestFocus: false,
            focusColor: Colors.transparent,
            onLongPress: _onLongPress,
            child: CupertinoButton(
              onPressed: _onPressed,
              child: _child,
              minSize: 0,
              padding: padding ?? EdgeInsets.zero,
              color: color,
              borderRadius: const BorderRadius.all(Radius.zero),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final btn = Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          _button(context),
          if (loading == true) MTLoader(radius: _radius),
        ],
      ),
    );
    return type == ButtonType.icon || !constrained ? btn : MTAdaptive.xxs(child: btn);
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
      middle: PlusIcon(color: type == ButtonType.main ? mainBtnTitleColor : mainColor),
      margin: const EdgeInsets.only(right: P2),
      onTap: onTap,
    );
  }
}

class MTCardButton extends StatelessWidget {
  const MTCardButton({
    required this.child,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.elevation,
    this.radius,
    this.padding,
    this.loading,
  });

  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onTap;
  final Function()? onLongPress;
  final double? elevation;
  final double? radius;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return MTButton(
      elevation: elevation,
      type: ButtonType.card,
      middle: Expanded(child: child),
      constrained: false,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? const EdgeInsets.all(P3),
      loading: loading,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class MTBadgeButton extends StatelessWidget {
  const MTBadgeButton({
    required this.showBadge,
    required this.type,
    this.leading,
    this.middle,
    this.trailing,
    this.titleText,
    this.margin,
    this.onTap,
    this.onLongPress,
    this.radius,
    this.padding,
    this.loading,
    this.constrained = true,
    this.uf = true,
  });

  final bool showBadge;
  final bool uf;
  final ButtonType type;
  final String? titleText;
  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? radius;
  final bool? loading;
  final bool constrained;

  static const _iconSize = P4;

  @override
  Widget build(BuildContext context) {
    final p = (padding ?? EdgeInsets.zero).copyWith(right: showBadge ? _iconSize / 2 : padding?.right, left: showBadge ? 0 : padding?.left);
    return MTButton(
      type: type,
      margin: margin,
      padding: p,
      leading: leading != null || showBadge
          ? Row(children: [
              if (showBadge) const MTPayBadge(iconSize: _iconSize),
              if (leading != null) leading!,
            ])
          : null,
      titleText: titleText,
      middle: middle,
      trailing: trailing,
      constrained: constrained,
      loading: loading,
      onTap: onTap,
      onLongPress: onLongPress,
      uf: uf,
    );
  }
}
