// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/circle.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/tariff_option.dart';
import '../_base/loader_screen.dart';
import 'usecases/tariff.dart';
import 'ws_controller.dart';

Future wsFeatures(WSController controller) async => await showMTDialog(_WSFeaturesDialog(controller));

class _WSFeaturesDialog extends StatelessWidget {
  const _WSFeaturesDialog(this._controller);
  final WSController _controller;
  Workspace get _ws => _controller.ws;
  Tariff get _tariff => _ws.tariff;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                pageTitle: loc.tariff_features_title,
              ),
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: _tariff.features.length,
                itemBuilder: (_, index) {
                  final f = _tariff.features[index];
                  final subscribed = _ws.hasExpense(f.code);
                  final actualPrice = _ws.finalPrice(f.code) ?? f.finalPrice;
                  final originalPrice = f.hasDiscount ? f.price : null;
                  final term = f.priceTerm(_ws.consumedEndDate(f.code));

                  return MTCard(
                    margin: const EdgeInsets.all(P3).copyWith(top: 0),
                    padding: const EdgeInsets.symmetric(vertical: P2, horizontal: P3),
                    borderSide: subscribed ? BorderSide(color: greenColor.resolve(context)) : null,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// название функции с иконкой
                        MTListTile(leading: f.image, middle: H3(f.title), bottomDivider: false, padding: EdgeInsets.zero),

                        /// описание функции
                        const SizedBox(height: P),
                        for (String d in f.description.split('\n'))
                          Row(
                            children: [
                              const MTCircle(size: P, color: f3Color),
                              const SizedBox(width: P),
                              Expanded(child: BaseText.f2(d, maxLines: 2, padding: const EdgeInsets.symmetric(vertical: P_2))),
                            ],
                          ),
                        const SizedBox(height: P2),
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  /// цена
                                  MTPrice(actualPrice, originalValue: originalPrice, color: mainColor, rowAlign: MainAxisAlignment.start),

                                  /// период тарификации, время до конца акции
                                  SmallText(term, maxLines: 1),
                                ],
                              ),
                            ),

                            /// кнопка для подключения / отключения функции
                            MTButton(
                              type: subscribed ? ButtonType.secondary : ButtonType.main,
                              titleText: subscribed ? loc.tariff_feature_unsubscribe_action_title : loc.tariff_feature_subscribe_action_title,
                              padding: const EdgeInsets.symmetric(horizontal: P6),
                              constrained: false,
                              onTap: () => _controller.toggleFeatureSubscription(context, f),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
