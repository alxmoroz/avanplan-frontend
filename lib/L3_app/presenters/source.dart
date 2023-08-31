// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../main.dart';
import '../components/circle.dart';
import '../components/colors.dart';
import '../components/colors_base.dart';
import '../components/constants.dart';
import '../components/list_tile.dart';
import '../components/text.dart';
import '../extra/services.dart';

extension SourceTypePresenter on SourceType {
  Widget get icon => active ? Image.asset('assets/icons/${code}_icon.png', height: P4) : const MTCircle(size: P4, color: b1Color);
  Widget get iconTitle => Row(children: [icon, const SizedBox(width: P), BaseText.medium('$this')]);
}

extension SourcePresenter on Source {
  SourceType get type => refsController.typeForCode(typeCode);
  double get _connectionIndicatorSize => P2;

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

    final textColor = (connected || isUnknown) ? null : f2Color;

    return MTListTile(
      leading: type.icon,
      middle: BaseText('$this', color: textColor),
      padding: padding,
      trailing: checking
          ? SizedBox(
              height: _connectionIndicatorSize,
              width: _connectionIndicatorSize,
              child: CircularProgressIndicator(color: f2Color.resolve(rootKey.currentContext!)),
            )
          : MTCircle(
              color: connected
                  ? Colors.green
                  : error
                      ? warningColor
                      : f2Color,
              size: _connectionIndicatorSize),
      bottomDivider: bottomBorder,
      onTap: onTap,
      color: standAlone ? null : Colors.transparent,
    );
  }
}
