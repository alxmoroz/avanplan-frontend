// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'adaptive.dart';
import 'colors.dart';

class MTBackgroundWrapper extends StatelessWidget {
  const MTBackgroundWrapper(this.child, {super.key, this.bg1Color, this.bg2Color});
  final Color? bg1Color;
  final Color? bg2Color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final big = isBigScreen(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (bg1Color ?? b2Color).resolve(context),
            (bg2Color ?? (big ? b1Color : b2Color)).resolve(context),
          ],
        ),
      ),
      child: child,
    );
  }
}
