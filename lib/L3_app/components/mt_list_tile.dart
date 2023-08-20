// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'mt_button.dart';
import 'mt_divider.dart';
import 'text_widgets.dart';

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
    this.dividerStartIndent,
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
  final double? dividerStartIndent;
  final bool topDivider;
  final bool bottomDivider;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool uf;

  static const _defaultIndent = P * 1.5;

  Widget get _border => MTDivider(
        height: 0,
        indent: dividerStartIndent ?? padding?.left ?? _defaultIndent,
        endIndent: padding?.right ?? _defaultIndent,
      );

  EdgeInsets get defaultPadding => const EdgeInsets.symmetric(horizontal: _defaultIndent).copyWith(top: P + topIndent, bottom: P);

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
              if (topDivider) _border,
              Padding(
                padding: padding ?? defaultPadding,
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
              if (bottomDivider) _border,
            ],
          )),
      color: (color ?? lightBackgroundColor).resolve(context),
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
      color: lightGreyColor,
    );
  }
}
