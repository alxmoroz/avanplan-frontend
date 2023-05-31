// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'icons.dart';
import 'mt_list_tile.dart';
import 'text_widgets.dart';

class MTCheckBoxTile extends StatelessWidget {
  const MTCheckBoxTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.description,
    this.titleColor,
    this.bottomBorder = false,
  });

  final String title;
  final bool value;
  final String? description;
  final Color? titleColor;
  final Function(bool?) onChanged;
  final bool bottomBorder;

  @override
  Widget build(BuildContext context) => MTListTile(
        middle: NormalText(title, color: titleColor),
        subtitle: description != null && description!.isNotEmpty ? SmallText(description!, maxLines: 2) : null,
        trailing: DoneIcon(value, solid: value),
        bottomBorder: bottomBorder,
        onTap: () => onChanged(!value),
      );
}
