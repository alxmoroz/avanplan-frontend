// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'button.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'divider.dart';
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
    this.color,
    this.padding,
    this.topIndent = 0,
    this.dividerLeftIndent,
    this.topDivider = false,
    this.bottomDivider = true,
    this.crossAxisAlignment,
    this.uf = true,
  });
  final Widget? leading;
  final Widget? middle;
  final Widget? subtitle;
  final String? titleText;
  final Widget? trailing;
  final Function()? onTap;
  final Color? color;
  final double topIndent;
  final EdgeInsets? padding;
  final double? dividerLeftIndent;
  final bool topDivider;
  final bool bottomDivider;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool uf;

  static const _defaultIndent = P18;

  Widget get _divider => MTDivider(
        height: 0,
        indent: dividerLeftIndent ?? padding?.left ?? _defaultIndent,
        endIndent: padding?.right ?? _defaultIndent,
      );

  EdgeInsets get _defaultPadding => EdgeInsets.only(
        left: _defaultIndent,
        top: P + topIndent,
        right: _defaultIndent,
        bottom: P,
      );

  @override
  Widget build(BuildContext context) {
    final _hoverColor = mainColor.withAlpha(10).resolve(context);
    final _splashColor = mainColor.withAlpha(10).resolve(context);

    final _onPressed = onTap != null ? () => actionWithUF(context, uf, onTap!) : null;

    return material(
      InkWell(
          onTap: _onPressed,
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
                    if (leading != null) ...[leading!, const SizedBox(width: P_2)],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (middle != null || titleText != null) middle ?? (titleText != null ? NormalText(titleText!) : Container()),
                          if (subtitle != null) subtitle!,
                        ],
                      ),
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
              ),
              if (bottomDivider) _divider,
            ],
          )),
      color: (color ?? b3Color).resolve(context),
    );
  }
}

class MTListSection extends StatelessWidget {
  const MTListSection(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return H3(
      title,
      padding: const EdgeInsets.symmetric(horizontal: P2).copyWith(top: P2, bottom: P_2),
      color: f2Color,
    );
  }
}
