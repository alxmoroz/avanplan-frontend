// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/circle.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/tariff_option.dart';
import '../../views/_base/loader_screen.dart';
import '../workspace/ws_controller.dart';

Future tariffManageableOptions(WSController controller) async => await showMTDialog<void>(_TManageableOptionsDialog(controller));

class _TManageableOptionsDialog extends StatelessWidget {
  const _TManageableOptionsDialog(this._controller);
  final WSController _controller;
  Workspace get _ws => _controller.ws;
  Invoice get _invoice => _ws.invoice;
  Tariff get _tariff => _invoice.tariff;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                title: loc.tariff_features_title,
              ),
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: _tariff.manageableOptions.length,
                itemBuilder: (_, index) {
                  final feature = _tariff.manageableOptions[index];
                  return MTCard(
                    margin: const EdgeInsets.all(P3).copyWith(top: 0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MTListTile(
                          leading: feature.image,
                          middle: H3(feature.title),
                          bottomDivider: false,
                        ),
                        for (String d in feature.description.split('\n'))
                          Row(
                            children: [
                              const SizedBox(width: P3),
                              const MTCircle(size: P, color: f3Color),
                              const SizedBox(width: P),
                              Expanded(child: BaseText.f2(d, maxLines: 2, padding: const EdgeInsets.symmetric(vertical: P_3))),
                              const SizedBox(width: P2),
                            ],
                          ),
                        MTListTile(
                          middle: MTPrice(feature.price, color: mainColor, align: TextAlign.left),
                          subtitle: BaseText.f2(loc.per_month_suffix, maxLines: 1),
                          trailing: MTButton.secondary(
                            titleText: loc.tariff_sign_action_title,
                            padding: const EdgeInsets.symmetric(horizontal: P8),
                            constrained: false,
                            // onTap: () => selectTariff(_controller),
                          ),
                          bottomDivider: false,
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
