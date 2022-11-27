// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'material_wrapper.dart';
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
    this.topBorder = false,
    this.bottomBorder = true,
  });
  final Widget? leading;
  final Widget? middle;
  final Widget? subtitle;
  final String? titleText;
  final Widget? trailing;
  final Function()? onTap;
  final bool topBorder;
  final bool bottomBorder;
  final Color? color;

  @override
  Widget build(BuildContext context) => material(
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: topBorder ? BorderSide(width: 1, color: borderColor.resolve(context)) : BorderSide.none,
                bottom: bottomBorder ? BorderSide(width: 1, color: borderColor.resolve(context)) : BorderSide.none,
              ),
            ),
            padding: const EdgeInsets.all(P),
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
        ),
        color: color?.resolve(context),
      );
}
