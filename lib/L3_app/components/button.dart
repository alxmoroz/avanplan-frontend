// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive.dart';
import 'colors.dart';
import 'constants.dart';
import 'gesture.dart';
import 'icons.dart';
import 'loader.dart';
import 'material_wrapper.dart';
import 'text.dart';

enum ButtonType { text, main, secondary, danger, safe, icon, card }

class MTButton extends StatelessWidget with GestureManaging {
  const MTButton({
    super.key,
    this.titleText,
    this.onTap,
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
    this.borderSide,
  });

  MTButton.main({
    super.key,
    this.titleText,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
  })  : type = ButtonType.main,
        titleColor = null,
        color = null,
        elevation = null,
        borderSide = BorderSide.none,
        onHover = null,
        uf = true;

  MTButton.secondary({
    super.key,
    this.titleText,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
  })  : type = ButtonType.secondary,
        titleColor = null,
        color = null,
        elevation = null,
        borderSide = null,
        onHover = null,
        uf = true;

  MTButton.danger({
    super.key,
    this.titleText,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
  })  : type = ButtonType.danger,
        titleColor = null,
        color = null,
        elevation = null,
        borderSide = BorderSide.none,
        onHover = null,
        uf = true;

  MTButton.safe({
    super.key,
    this.titleText,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
  })  : type = ButtonType.safe,
        titleColor = null,
        color = null,
        elevation = null,
        borderSide = BorderSide.none,
        onHover = null,
        uf = true;

  const MTButton.icon(
    Widget icon, {
    super.key,
    this.margin,
    this.padding,
    this.color,
    this.elevation,
    this.loading,
    this.onTap,
    this.onHover,
    this.uf = true,
    this.minSize,
  })  : type = ButtonType.icon,
        middle = icon,
        titleText = null,
        leading = null,
        trailing = null,
        titleColor = null,
        constrained = false,
        borderSide = null;

  final ButtonType type;
  final String? titleText;
  final Function()? onTap;
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
  final BorderSide? borderSide;

  final bool? loading;
  final bool uf;
  final Size? minSize;

  bool get _enabled => loading != true && onTap != null;
  bool get _custom => [ButtonType.card].contains(type);
  Color get _titleColor => _enabled || _custom
      ? (titleColor ??
          (type == ButtonType.main
              ? mainBtnTitleColor
              : [ButtonType.danger, ButtonType.safe].contains(type)
                  ? b3Color
                  : mainColor))
      : f2Color;
  Size get _minSize => minSize ?? const Size(MIN_BTN_HEIGHT, MIN_BTN_HEIGHT);
  double get _radius => (type == ButtonType.card ? DEF_BORDER_RADIUS : _minSize.height / 2);

  ButtonStyle _style(BuildContext context) {
    final btnColor = (_enabled || _custom
            ? (color ??
                (type == ButtonType.main
                    ? mainColor
                    : type == ButtonType.danger
                        ? dangerColor
                        : type == ButtonType.safe
                            ? greenColor
                            : b3Color))
            : b1Color)
        .resolve(context);

    return ElevatedButton.styleFrom(
      padding: padding ?? EdgeInsets.zero,
      foregroundColor: _titleColor.resolve(context),
      backgroundColor: btnColor,
      disabledForegroundColor: btnColor,
      disabledBackgroundColor: btnColor,
      minimumSize: _minSize,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
      side: borderSide ?? (type == ButtonType.secondary ? BorderSide(color: _titleColor.resolve(context), width: 1) : BorderSide.none),
      splashFactory: NoSplash.splashFactory,
      visualDensity: VisualDensity.standard,
      shadowColor: b1Color.resolve(context),
      elevation: elevation ?? buttonElevation,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Function()? get _onPressed => _enabled && onTap != null ? () => tapAction(uf, onTap!, fbType: FeedbackType.light) : null;

  Widget _button(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: P)],
        middle ?? (titleText != null ? Flexible(child: BaseText.medium(titleText!, color: _titleColor, maxLines: 1)) : const SizedBox()),
        if (trailing != null) ...[const SizedBox(width: P), trailing!],
      ],
    );

    return [
      ButtonType.main,
      ButtonType.secondary,
      ButtonType.danger,
      ButtonType.safe,
      ButtonType.card,
    ].contains(type)
        ? OutlinedButton(
            onPressed: _onPressed,
            onHover: onHover,
            style: _style(context),
            clipBehavior: Clip.hardEdge,
            child: child,
          )
        : material(
            InkWell(
              onHover: onHover,
              onTap: onHover != null ? () {} : null,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              canRequestFocus: false,
              focusColor: Colors.transparent,
              child: CupertinoButton(
                onPressed: _onPressed,
                minSize: 0,
                padding: padding ?? EdgeInsets.zero,
                color: color,
                borderRadius: const BorderRadius.all(Radius.zero),
                child: child,
              ),
            ),
          );
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
  const MTPlusButton(this.onTap, {super.key, this.type = ButtonType.main});
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
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.elevation,
    this.radius,
    this.loading,
    this.onTap,
    this.onLongPress,
    this.borderSide,
  });

  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? elevation;
  final double? radius;
  final bool? loading;
  final BorderSide? borderSide;

  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return MTButton(
      borderSide: borderSide,
      elevation: elevation,
      type: ButtonType.card,
      middle: Expanded(child: child),
      constrained: false,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? const EdgeInsets.all(P3),
      loading: loading,
      onTap: onTap,
    );
  }
}
