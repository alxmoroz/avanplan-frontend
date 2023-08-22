// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_field_data.dart';
import 'mt_list_tile.dart';
import 'mt_loader.dart';
import 'text_widgets.dart';

class MTField extends StatelessWidget {
  const MTField(
    this.fd, {
    this.onSelect,
    this.leading,
    this.value,
    this.bottomDivider = false,
    this.dividerStartIndent,
    this.padding,
    this.color,
  });

  final MTFieldData fd;
  final Widget? leading;
  final Widget? value;
  final VoidCallback? onSelect;

  final bool bottomDivider;
  final double? dividerStartIndent;
  final EdgeInsets? padding;
  final Color? color;

  bool get _hasValue => value != null;

  @override
  Widget build(BuildContext context) {
    final Widget child = value ?? NormalText(fd.text);

    return Stack(
      alignment: Alignment.center,
      children: [
        MTListTile(
          leading: leading != null ? SizedBox(width: P3 + P_2, child: Center(child: leading)) : null,
          middle: _hasValue && fd.label.isNotEmpty ? NormalText(fd.label, color: fgL2Color, height: 1, sizeScale: 0.9) : null,
          subtitle: _hasValue
              ? child
              : LightText(
                  fd.placeholder,
                  color: fgL2Color,
                  padding: const EdgeInsets.symmetric(vertical: P_2),
                ),
          bottomDivider: bottomDivider,
          dividerStartIndent: dividerStartIndent,
          onTap: onSelect,
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: padding,
          color: color,
        ),
        if (fd.loading) const MTLoader(),
      ],
    );
  }
}
