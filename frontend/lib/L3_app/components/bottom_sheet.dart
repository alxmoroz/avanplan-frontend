// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'constants.dart';

double radius = onePadding;

class MTBottomSheet extends StatelessWidget {
  const MTBottomSheet(this.bodyWidget);

  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Container(
        decoration: BoxDecoration(
          color: darkBackgroundColor.resolve(context),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: radius),
            bodyWidget,
          ],
        ),
      ),
    );
  }
}
