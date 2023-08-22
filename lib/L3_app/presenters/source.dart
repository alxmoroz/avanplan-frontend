// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../main.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/mt_circle.dart';
import '../components/mt_list_tile.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';

extension SourceTypePresenter on SourceType {
  Widget get icon => active ? Image.asset('assets/icons/${code}_icon.png', height: P2) : const MTCircle(size: P2, color: fgL1Color);
  Widget get iconTitle => Row(children: [icon, const SizedBox(width: P_2), MediumText('$this')]);
}

extension SourcePresenter on Source {
  SourceType get type => refsController.typeForCode(typeCode);
  double get _connectionIndicatorSize => P;

  Widget listTile({
    EdgeInsets? padding,
    VoidCallback? onTap,
    bool bottomBorder = false,
    bool standAlone = true,
  }) {
    final isUnknown = state == SrcState.unknown;
    final connected = state == SrcState.connected;
    final checking = state == SrcState.checking;
    final error = state == SrcState.error;

    final textColor = (connected || isUnknown) ? null : fgL2Color;

    return MTListTile(
      leading: type.icon,
      middle: NormalText('$this', color: textColor),
      padding: padding,
      trailing: checking
          ? SizedBox(
              height: _connectionIndicatorSize,
              width: _connectionIndicatorSize,
              child: CircularProgressIndicator(color: fgL2Color.resolve(rootKey.currentContext!)),
            )
          : MTCircle(
              color: connected
                  ? Colors.green
                  : error
                      ? warningColor
                      : fgL2Color,
              size: _connectionIndicatorSize),
      bottomDivider: bottomBorder,
      onTap: onTap,
      color: standAlone ? null : Colors.transparent,
    );
  }
}
