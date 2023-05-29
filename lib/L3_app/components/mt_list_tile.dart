// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'material_wrapper.dart';
import 'mt_divider.dart';
import 'text_widgets.dart';

class MTListTile extends StatelessWidget {
  const MTListTile({
    this.leading,
    this.middle,
    this.subtitle,
    this.titleText,
    this.trailing,
    this.onTap,
    this.color,
    this.padding,
    this.topBorder = false,
    this.bottomBorder = true,
  });
  final Widget? leading;
  final Widget? middle;
  final Widget? subtitle;
  final String? titleText;
  final Widget? trailing;
  final Function()? onTap;
  final Color? color;
  final EdgeInsets? padding;
  final bool topBorder;
  final bool bottomBorder;

  Widget get _border => MTDivider(height: 0, indent: padding?.left ?? P2, endIndent: padding?.right ?? P2);

  @override
  Widget build(BuildContext context) => material(
        InkWell(
            onTap: onTap,
            child: Column(
              children: [
                if (topBorder) _border,
                Padding(
                  padding: (padding ?? const EdgeInsets.symmetric(horizontal: P2, vertical: P)).add(const EdgeInsets.symmetric(horizontal: P_6)),
                  child: Row(
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
                if (bottomBorder) _border,
              ],
            )),
        color: color?.resolve(context),
      );
}
