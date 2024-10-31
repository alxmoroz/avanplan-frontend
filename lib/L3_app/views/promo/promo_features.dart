// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../my_account/usecases/onboarding.dart';
import '../workspace/ws_controller.dart';
import '../workspace/ws_features_dialog.dart';

// NB! Этот диалог вызывается только из квиза создания проекта
// NB! Для онбординга проверка наличия включенных функций не нужна, т.к. пользователь в своём РП их ещё точно не включил.
Future showPromoFeatures(Workspace ws) async {
  if (!ws.allProjectOptionsUsed && !myAccountController.promoFeaturesViewed) {
    await showMTDialog(_PromoFeaturesDialog(ws));
    myAccountController.registerPromoFeaturesViewed();
  }
}

class _PromoFeaturesDialog extends StatelessWidget {
  const _PromoFeaturesDialog(this.ws);
  final Workspace ws;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      body: ListView(
        shrinkWrap: true,
        children: [PromoFeatures(ws)],
      ),
      minBottomPadding: P3,
    );
  }
}

class PromoFeatures extends StatelessWidget {
  const PromoFeatures(this.ws, {super.key, this.onLater});

  final Workspace ws;
  final VoidCallback? onLater;

  Future _later(BuildContext context) async {
    (onLater ?? () => Navigator.of(context).pop())();
  }

  Future _subscribe(BuildContext context) async {
    await wsFeatures(WSController(wsIn: ws));
    if (context.mounted) _later(context);
  }

  @override
  Widget build(BuildContext context) {
    return MTAdaptive.s(
      force: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MTImage(ImageName.promo_features.name),
            const SizedBox(height: P6),
            H2(loc.promo_features_title, align: TextAlign.center),
            const SizedBox(height: P3),
            for (String t in loc.promo_features_text.split('\n'))
              Padding(
                padding: const EdgeInsets.only(top: P3),
                child: Row(
                  children: [
                    const StarIcon(size: P6),
                    const SizedBox(width: P2),
                    Expanded(child: BaseText(t, maxLines: 2)),
                  ],
                ),
              ),
            const SizedBox(height: P6),
            MTButton.main(
              titleText: loc.promo_features_subscribe_title,
              onTap: () => _subscribe(context),
            ),
            MTButton.secondary(
              titleText: loc.later,
              margin: const EdgeInsets.only(top: P3),
              onTap: () => _later(context),
            ),
          ],
        ),
      ),
    );
  }
}
