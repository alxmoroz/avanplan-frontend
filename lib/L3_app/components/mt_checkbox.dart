// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_widgets.dart';

class MTCheckBoxTile extends StatelessWidget {
  const MTCheckBoxTile({required this.title, required this.value, required this.onChanged, this.description});

  final String title;
  final bool value;
  final String? description;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) => Container(
        child: CheckboxListTile(
          title: MediumText(title, color: mainColor),
          subtitle: description != null && description!.isNotEmpty ? SmallText(description!, maxLines: 2) : null,
          value: value,
          onChanged: onChanged,
          side: BorderSide(color: mainColor.resolve(context), width: 2),
          activeColor: mainColor.resolve(context),
        ),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0, color: borderColor.resolve(context)))),
      );
}
