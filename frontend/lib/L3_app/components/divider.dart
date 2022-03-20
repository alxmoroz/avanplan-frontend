// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'colors.dart';

class MTDivider extends StatelessWidget {
  const MTDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(color: borderColor.resolve(context));
  }
}
