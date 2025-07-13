// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text.dart';
import 'adaptive.dart';
import 'constants.dart';
import 'gesture.dart';
import 'icons.dart';
import 'list_tile.dart';
import 'loader.dart';
import 'material_wrapper.dart';

enum MTButtonType {
  text,
  main,
  secondary,
  danger,
  safe,
  icon,
  card;

  bool get isCustom => [MTButtonType.card].contains(this);
  bool get isMain => this == main;
  bool get isSecondary => this == secondary;
  bool get isDanger => this == danger;
  bool get isText => this == text;
  bool get isCard => this == card;
  bool get isSafe => this == safe;
}

class MTButton extends StatelessWidget with GestureManaging {
  const MTButton({
    super.key,
    this.titleText,
    this.titleTextAlign,
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
    this.type = MTButtonType.text,
    this.uf = true,
    this.minSize,
    this.borderSide,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  MTButton.main({
    super.key,
    this.titleText,
    this.titleTextAlign,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.mainAxisAlignment = MainAxisAlignment.center,
  })  : type = MTButtonType.main,
        titleColor = null,
        color = null,
        elevation = null,
        borderSide = BorderSide.none,
        onHover = null,
        uf = true;

  MTButton.secondary({
    super.key,
    this.titleText,
    this.titleTextAlign,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.mainAxisAlignment = MainAxisAlignment.center,
  })  : type = MTButtonType.secondary,
        titleColor = null,
        color = null,
        elevation = null,
        borderSide = null,
        onHover = null,
        uf = true;

  MTButton.danger({
    super.key,
    this.titleText,
    this.titleTextAlign,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.mainAxisAlignment = MainAxisAlignment.center,
  })  : type = MTButtonType.danger,
        titleColor = null,
        color = null,
        elevation = null,
        borderSide = BorderSide.none,
        onHover = null,
        uf = true;

  MTButton.safe({
    super.key,
    this.titleText,
    this.titleTextAlign,
    this.onTap,
    this.leading,
    this.middle,
    this.trailing,
    this.constrained = true,
    this.padding,
    this.margin,
    this.loading,
    this.minSize,
    this.borderRadius,
    this.borderRadiusGeometry,
    this.mainAxisAlignment = MainAxisAlignment.center,
  })  : type = MTButtonType.safe,
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
    this.borderRadius,
    this.borderRadiusGeometry,
    this.mainAxisAlignment = MainAxisAlignment.center,
  })  : type = MTButtonType.icon,
        middle = icon,
        titleText = null,
        titleTextAlign = null,
        leading = null,
        trailing = null,
        titleColor = null,
        constrained = false,
        borderSide = null;

  final MTButtonType type;
  final TextAlign? titleTextAlign;
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
  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final BorderSide? borderSide;
  final MainAxisAlignment mainAxisAlignment;

  final bool? loading;
  final bool uf;
  final Size? minSize;

  bool get _enabled => loading != true && onTap != null;

  Color _titleColor(BuildContext context) {
    Color tc = (titleColor ??
            (type.isMain
                ? mainBtnTitleColor
                : [MTButtonType.danger, MTButtonType.safe].contains(type)
                    ? b3Color
                    : mainColor))
        .resolve(context);

    return _enabled || type.isCustom ? tc : tc.withValues(alpha: 0.7);
  }

  Size get _minSize => minSize ?? const Size(MIN_BTN_HEIGHT, MIN_BTN_HEIGHT);
  double get _radius => borderRadius ?? (type.isCard ? DEF_BORDER_RADIUS : _minSize.height / 2);

  ButtonStyle _style(BuildContext context) {
    Color btnColor = (color ??
            (type.isMain
                ? mainColor
                : type.isDanger
                    ? dangerColor
                    : type.isSafe
                        ? safeColor
                        : b3Color))
        .resolve(context);
    if (!(_enabled || type.isCustom)) btnColor = btnColor.withValues(alpha: 0.42);

    Color titleColor = _titleColor(context);

    return ElevatedButton.styleFrom(
      padding: padding ?? EdgeInsets.zero,
      foregroundColor: titleColor,
      backgroundColor: btnColor,
      disabledForegroundColor: btnColor,
      disabledBackgroundColor: btnColor,
      minimumSize: _minSize,
      shape: RoundedRectangleBorder(borderRadius: borderRadiusGeometry ?? BorderRadius.circular(_radius)),
      side: borderSide ?? (type.isSecondary ? BorderSide(color: titleColor, width: 1) : BorderSide.none),
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
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: P2)],
        middle ??
            (titleText != null
                ? Flexible(
                    child: BaseText.medium(
                    titleText!,
                    align: titleTextAlign,
                    color: _titleColor(context),
                    maxLines: 1,
                  ))
                : const SizedBox()),
        if (trailing != null) ...[const SizedBox(width: P), trailing!],
      ],
    );

    return [
      MTButtonType.main,
      MTButtonType.secondary,
      MTButtonType.danger,
      MTButtonType.safe,
      MTButtonType.card,
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
                minimumSize: Size.zero,
                padding: padding ?? EdgeInsets.zero,
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
                child: child,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final btn = type == MTButtonType.text
        ? MTListTile(
            leading: leading,
            middle: middle ??
                (titleText != null
                    ? BaseText(
                        titleText!,
                        color: _titleColor(context),
                        maxLines: 1,
                        align: titleTextAlign ?? TextAlign.center,
                      )
                    : const SizedBox()),
            padding: padding,
            margin: margin,
            trailing: trailing,
            onHover: onHover,
            loading: loading,
            onTap: _onPressed,
          )
        : Padding(
            padding: margin ?? EdgeInsets.zero,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: [
                _button(context),
                if (loading == true) MTLoader(borderRadius: _radius),
              ],
            ),
          );
    return type == MTButtonType.icon || !constrained ? btn : MTAdaptive.xxs(child: btn);
  }
}

class MTPlusButton extends StatelessWidget {
  const MTPlusButton(this.onTap, {super.key, this.type = MTButtonType.main});
  final VoidCallback? onTap;
  final MTButtonType type;

  @override
  Widget build(BuildContext context) {
    return MTButton(
      type: type,
      middle: PlusIcon(color: type == MTButtonType.main ? mainBtnTitleColor : mainColor),
      margin: const EdgeInsets.only(right: P2),
      onTap: onTap,
    );
  }
}

class MTCardButton extends StatelessWidget {
  const MTCardButton({
    super.key,
    required this.middle,
    this.trailing,
    this.margin = EdgeInsets.zero,
    this.padding = DEF_PADDING,
    this.elevation,
    this.borderRadius,
    this.loading,
    this.onTap,
    this.color,
    this.borderSide,
    this.uf = true,
  });

  final Widget middle;
  final Widget? trailing;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? elevation;
  final double? borderRadius;
  final bool? loading;
  final BorderSide? borderSide;
  final bool uf;
  final Color? color;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MTButton(
      borderSide: borderSide,
      borderRadius: borderRadius,
      elevation: elevation,
      color: color,
      type: MTButtonType.card,
      middle: Expanded(child: middle),
      trailing: trailing,
      constrained: false,
      margin: margin,
      padding: padding,
      loading: loading,
      uf: uf,
      onTap: onTap,
    );
  }
}
