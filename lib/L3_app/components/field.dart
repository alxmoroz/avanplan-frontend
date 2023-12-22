// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors_base.dart';
import 'constants.dart';
import 'field_data.dart';
import 'list_tile.dart';
import 'text.dart';

class MTField extends StatelessWidget {
  const MTField(
    this.fd, {
    this.leading,
    this.value,
    this.trailing,
    this.bottomDivider = false,
    this.dividerIndent,
    this.dividerEndIndent,
    this.margin,
    this.padding,
    this.color,
    this.minHeight,
    this.crossAxisAlignment,
    this.loading = false,
    this.onTap,
    this.onHover,
  });

  final MTFieldData fd;
  final Widget? leading;
  final Widget? value;
  final Widget? trailing;
  final Function()? onTap;
  final Function(bool)? onHover;

  final bool bottomDivider;
  final double? dividerIndent;
  final double? dividerEndIndent;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final double? minHeight;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool loading;

  bool get _hasValue => value != null;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: leading != null ? Container(width: P7, child: leading, alignment: Alignment.center) : null,
      middle: _hasValue && fd.label.isNotEmpty ? SmallText(fd.label, color: f3Color, maxLines: 1) : null,
      subtitle: _hasValue ? value : BaseText.f3(fd.placeholder, maxLines: 1),
      bottomDivider: bottomDivider,
      dividerIndent: dividerIndent,
      dividerEndIndent: dividerEndIndent,
      crossAxisAlignment: crossAxisAlignment ?? (_hasValue ? CrossAxisAlignment.start : null),
      margin: margin,
      padding: padding,
      color: color,
      minHeight: minHeight,
      loading: fd.loading || loading,
      onTap: onTap,
      onHover: onHover,
    );
  }
}
