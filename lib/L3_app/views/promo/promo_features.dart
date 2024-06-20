// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../workspace/ws_controller.dart';
import '../workspace/ws_features_dialog.dart';

class PromoFeatures extends StatelessWidget {
  const PromoFeatures(this.ws, {super.key, this.onNext});

  final Workspace ws;
  final VoidCallback? onNext;

  Future _next(BuildContext context) async {
    (onNext ?? () => Navigator.of(context).pop())();
  }

  Future _subscribe(BuildContext context) async {
    await wsFeatures(WSController(wsIn: ws));
    if (context.mounted) _next(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const MTImage('promo_features'),
        H2(
          loc.promo_features_title,
          align: TextAlign.center,
          padding: const EdgeInsets.all(P6).copyWith(bottom: P3),
        ),
        for (String t in loc.promo_features_text.split('\n'))
          Padding(
            padding: const EdgeInsets.only(top: P3, left: P3, right: P6),
            child: Row(
              children: [
                const StarIcon(size: P6),
                const SizedBox(width: P3),
                Expanded(child: BaseText(t, maxLines: 2)),
              ],
            ),
          ),
        const SizedBox(height: P6),
        MTButton.secondary(titleText: loc.later, onTap: () => _next(context)),
        const SizedBox(height: P3),
        MTButton.main(
          titleText: loc.promo_features_subscribe_title,
          onTap: () => _subscribe(context),
        ),
      ],
    );
  }
}
