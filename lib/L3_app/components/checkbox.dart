// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text.dart';
import 'icons.dart';
import 'list_tile.dart';

class MTCheckBoxTile extends StatelessWidget {
  const MTCheckBoxTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    this.description,
    this.titleColor,
    this.color,
    this.leading,
    this.bottomDivider = true,
    this.dividerIndent,
    this.uf = true,
  });

  final String title;
  final bool value;
  final String? description;
  final Color? titleColor;
  final Color? color;
  final Widget? leading;
  final Function(bool?)? onChanged;
  final bool bottomDivider;
  final double? dividerIndent;
  final bool uf;

  bool get _disabled => onChanged == null;

  @override
  Widget build(BuildContext context) => MTListTile(
        leading: leading,
        middle: BaseText(title, color: _disabled ? f3Color : titleColor, maxLines: 2),
        subtitle: description != null && description!.isNotEmpty ? SmallText(description!, color: _disabled ? f3Color : null, maxLines: 1) : null,
        trailing: CheckboxIcon(value, solid: value, color: _disabled ? f3Color : mainColor),
        color: color ?? b3Color,
        bottomDivider: bottomDivider,
        dividerIndent: dividerIndent,
        uf: uf,
        onTap: onChanged != null ? () => onChanged!(!value) : null,
      );
}
