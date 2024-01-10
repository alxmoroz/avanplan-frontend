// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'colors_base.dart';

class MTBackgroundWrapper extends StatelessWidget {
  const MTBackgroundWrapper(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            b2Color.resolve(context),
            b1Color.resolve(context),
          ],
        ),
      ),
      child: child,
    );
  }
}
