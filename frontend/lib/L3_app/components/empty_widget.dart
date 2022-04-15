// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_widgets.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    required this.title,
    this.addTitle,
    this.onAdd,
    this.color,
  });

  final String title;
  final VoidCallback? onAdd;
  final String? addTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: H4(title, align: TextAlign.center, color: color ?? lightGreyColor),
      subtitle: addTitle != null ? H3('+ $addTitle', align: TextAlign.center, color: mainColor, padding: EdgeInsets.only(top: onePadding)) : null,
      onTap: onAdd,
    );
  }
}
