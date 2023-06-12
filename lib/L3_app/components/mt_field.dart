// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'mt_field_data.dart';
import 'mt_list_tile.dart';
import 'text_widgets.dart';

class MTField extends StatelessWidget {
  const MTField(
    this.fd, {
    this.leading,
    this.value,
    required this.trailing,
    required this.onTap,
    required this.bottomDivider,
    required this.dividerStartIndent,
  });

  final MTFieldData fd;
  final Widget? leading;
  final Widget? value;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool bottomDivider;
  final double? dividerStartIndent;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null || fd.text.isNotEmpty;
    final Widget child = value ?? NormalText(fd.text);

    return Stack(
      alignment: Alignment.center,
      children: [
        MTListTile(
          bottomDivider: bottomDivider,
          dividerStartIndent: dividerStartIndent,
          middle: hasValue ? LightText(fd.label, color: lightGreyColor, sizeScale: 0.85, height: 1) : null,
          subtitle: hasValue ? child : LightText(fd.placeholder, color: lightGreyColor),
          leading: leading,
          onTap: onTap,
          trailing: trailing,
        ),
        if (fd.loading) ...[
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              color: backgroundColor.resolve(context).withAlpha(120),
            ),
          ),
          CircularProgressIndicator(color: mainColor.resolve(context)),
        ]
      ],
    );
  }
}
