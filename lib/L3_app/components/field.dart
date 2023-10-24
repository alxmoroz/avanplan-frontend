// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors_base.dart';
import 'constants.dart';
import 'field_data.dart';
import 'list_tile.dart';
import 'loader.dart';
import 'text.dart';

class MTField extends StatelessWidget {
  const MTField(
    this.fd, {
    this.onSelect,
    this.leading,
    this.value,
    this.bottomDivider = false,
    this.dividerStartIndent,
    this.margin,
    this.padding,
    this.color,
  });

  final MTFieldData fd;
  final Widget? leading;
  final Widget? value;
  final VoidCallback? onSelect;

  final bool bottomDivider;
  final double? dividerStartIndent;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;

  bool get _hasValue => value != null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTListTile(
          leading: leading != null ? SizedBox(width: P6, child: Center(child: leading)) : null,
          middle: _hasValue && fd.label.isNotEmpty ? SmallText(fd.label, color: f3Color, height: 1) : null,
          subtitle: _hasValue ? value : BaseText.f3(fd.placeholder, padding: const EdgeInsets.symmetric(vertical: P)),
          bottomDivider: bottomDivider,
          dividerLeftIndent: dividerStartIndent,
          onTap: onSelect,
          crossAxisAlignment: CrossAxisAlignment.start,
          margin: margin,
          padding: padding,
          color: color,
        ),
        if (fd.loading) const MTLoader(),
      ],
    );
  }
}
