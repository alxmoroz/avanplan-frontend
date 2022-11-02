// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';
import 'constants.dart';
import 'mt_card.dart';

class MTBottomSheet extends StatelessWidget {
  const MTBottomSheet(this.bodyWidget);

  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(navigatorKey.currentContext ?? context);
    return Container(
      constraints: BoxConstraints(maxHeight: mq.size.height - mq.padding.top - onePadding * 1),
      child: MTCard(child: bodyWidget, radius: onePadding),
    );
  }
}
