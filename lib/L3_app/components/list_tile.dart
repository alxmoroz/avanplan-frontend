// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'button.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'divider.dart';
import 'loader.dart';
import 'material_wrapper.dart';
import 'text.dart';

class MTListTile extends StatelessWidget with FocusManaging {
  const MTListTile({
    this.leading,
    this.middle,
    this.subtitle,
    this.titleText,
    this.trailing,
    this.onTap,
    this.onHover,
    this.color,
    this.padding,
    this.margin,
    this.dividerIndent,
    this.dividerEndIndent,
    this.topDivider = false,
    this.bottomDivider = true,
    this.crossAxisAlignment,
    this.uf = true,
    this.loading,
    this.minHeight,
  });
  final Widget? leading;
  final Widget? middle;
  final Widget? subtitle;
  final String? titleText;
  final Widget? trailing;
  final Function()? onTap;
  final Function(bool)? onHover;

  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? dividerIndent;
  final double? dividerEndIndent;
  final bool topDivider;
  final bool bottomDivider;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool uf;
  final bool? loading;
  final double? minHeight;

  static const _defaultIndent = P3;

  Widget get _divider => MTDivider(
        indent: dividerIndent ?? padding?.left ?? _defaultIndent,
        endIndent: dividerEndIndent ?? padding?.right ?? _defaultIndent,
      );

  EdgeInsets get _defaultPadding => const EdgeInsets.symmetric(horizontal: _defaultIndent, vertical: P2);

  @override
  Widget build(BuildContext context) {
    final _hoverColor = mainColor.withAlpha(10).resolve(context);
    final _splashColor = mainColor.withAlpha(10).resolve(context);

    final _onPressed = onTap != null ? () => tapAction(context, uf, onTap!) : null;
    final _hasLeading = leading != null;
    final _hasMiddle = middle != null || titleText != null;
    final _hasSubtitle = subtitle != null;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        Padding(
          padding: margin ?? EdgeInsets.zero,
          child: material(
            InkWell(
              onTap: _onPressed,
              onHover: onHover,
              hoverColor: _hoverColor,
              highlightColor: _splashColor,
              splashColor: _splashColor,
              canRequestFocus: false,
              focusColor: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (topDivider) _divider,
                  Padding(
                    padding: padding ?? _defaultPadding,
                    child: Row(
                      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: minHeight ?? P6),
                        if (_hasLeading) ...[
                          leading!,
                          const SizedBox(width: P2),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (_hasMiddle) middle ?? BaseText(titleText!, maxLines: 1),
                              if (_hasSubtitle) ...[
                                if (_hasMiddle) const SizedBox(height: P),
                                subtitle!,
                              ],
                            ],
                          ),
                        ),
                        if (trailing != null) trailing!,
                      ],
                    ),
                  ),
                  if (bottomDivider) _divider,
                ],
              ),
            ),
            color: (color ?? b3Color).resolve(context),
          ),
        ),
        if (loading == true) const MTLoader(),
      ],
    );
  }
}

class MTListSection extends StatelessWidget {
  const MTListSection({
    this.leading,
    this.middle,
    this.titleText,
    this.trailing,
    this.color,
    this.topPadding,
    this.onTap,
  });

  final Widget? leading;
  final Widget? middle;
  final String? titleText;
  final Widget? trailing;
  final Color? color;
  final double? topPadding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: leading,
      middle: middle ?? BaseText.f2(titleText ?? ''),
      trailing: trailing,
      padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: topPadding ?? P3, bottom: P),
      color: color ?? Colors.transparent,
      bottomDivider: false,
      onTap: onTap,
    );
  }
}
