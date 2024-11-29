// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';

class MTDashboardCard extends StatelessWidget {
  const MTDashboardCard(
    this.title, {
    super.key,
    this.body,
    this.hasLeftMargin = false,
    this.onTap,
  });
  final String title;
  final Widget? body;
  final bool hasLeftMargin;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MTButton(
      margin: EdgeInsets.only(left: hasLeftMargin ? P2 : 0),
      padding: const EdgeInsets.all(P2),
      type: MTButtonType.card,
      middle: Container(
        constraints: const BoxConstraints(maxWidth: 250),
        child: Column(
          children: [
            if (title.isNotEmpty) BaseText.f2(title, align: TextAlign.center, maxLines: 1, padding: const EdgeInsets.only(bottom: P2)),
            if (body != null) body!,
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
