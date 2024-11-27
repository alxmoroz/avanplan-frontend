// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/tariff_option.dart';
import 'ws_controller.dart';
import 'ws_feature_dialog.dart';

Future wsFeatures(WSController controller) async => await showMTDialog(_WSFeaturesDialog(controller));

class _WSFeaturesDialog extends StatelessWidget {
  const _WSFeaturesDialog(this._controller);
  final WSController _controller;

  @override
  Widget build(BuildContext context) {
    Workspace ws = _controller.ws;
    Tariff tariff = ws.tariff;
    final features = tariff.features;
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.tariff_features_title),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: features.length,
        itemBuilder: (_, index) {
          final f = features[index];
          final subscribed = ws.hasExpense(f.code);
          return MTListTile(
            leading: f.image,
            middle: Row(
              children: [
                Expanded(child: BaseText(f.title, maxLines: 1)),
                if (subscribed) BaseText(loc.tariff_feature_subscribed_title, color: greenColor),
              ],
            ),
            subtitle: SmallText(f.subtitle, maxLines: 1),
            trailing: kIsWeb ? null : const ChevronIcon(),
            dividerIndent: FEATURE_IMAGE_SIZE + P5,
            bottomDivider: index < features.length - 1,
            onTap: () => wsFeature(_controller, index),
          );
        },
      ),
    );
  }
}
