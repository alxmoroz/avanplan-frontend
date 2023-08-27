// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'icons.dart';
import 'list_tile.dart';
import 'text.dart';

class MTCheckBoxTile extends StatelessWidget {
  const MTCheckBoxTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.description,
    this.titleColor,
    this.color,
    this.bottomBorder = false,
  });

  final String title;
  final bool value;
  final String? description;
  final Color? titleColor;
  final Color? color;
  final Function(bool?) onChanged;
  final bool bottomBorder;

  @override
  Widget build(BuildContext context) => MTListTile(
        middle: NormalText(title, color: titleColor, maxLines: 2),
        subtitle: description != null && description!.isNotEmpty ? SmallText(description!, maxLines: 1) : null,
        trailing: DoneIcon(value, solid: value),
        color: color,
        bottomDivider: bottomBorder,
        onTap: () => onChanged(!value),
      );
}
