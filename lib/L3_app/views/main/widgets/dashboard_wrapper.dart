// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/mt_card.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper(this.child, {this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MTCardButton(
      child: child,
      onTap: onTap,
    );
  }
}
