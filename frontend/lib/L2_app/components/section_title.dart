// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'text/text_widgets.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title);

  @protected
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyColor6(context),
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: NormalText(title),
    );
  }
}
