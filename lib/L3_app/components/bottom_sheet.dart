// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'card.dart';
import 'constants.dart';

double radius = onePadding;

class MTBottomSheet extends StatelessWidget {
  const MTBottomSheet(this.bodyWidget, this.parentContext);

  final Widget bodyWidget;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(parentContext);
    return MTCard(
      margin: EdgeInsets.only(top: mq.viewPadding.top + onePadding),
      radius: onePadding,
      body: Expanded(child: bodyWidget),
      onTap: FocusScope.of(context).unfocus,
    );
  }
}
