// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../components/circle.dart';
import '../components/circular_progress.dart';
import '../components/colors.dart';
import '../components/colors_base.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/list_tile.dart';
import '../components/text.dart';
import '../extra/services.dart';

extension SourceTypePresenter on SourceType {
  Widget icon({double? size}) => custom ? MailIcon(size: size ?? P4) : Image.asset('assets/icons/${code}_icon.png', height: size ?? P4);
  Widget iconTitle({double? size}) => Row(children: [icon(size: size), const SizedBox(width: P), BaseText('$this')]);
}

extension SourcePresenter on Source {
  SourceType get type => refsController.typeForCode(typeCode);
  double get _connectionIndicatorSize => P2;

  Widget listTile({
    EdgeInsets? padding,
    VoidCallback? onTap,
    double? iconSize,
    bool bottomBorder = false,
    bool standAlone = true,
  }) {
    final isUnknown = state == SrcState.unknown;
    final connected = state == SrcState.connected;
    final checking = state == SrcState.checking;
    final error = state == SrcState.error;

    final textColor = (connected || isUnknown) ? null : f2Color;

    return MTListTile(
      leading: type.icon(size: iconSize),
      middle: BaseText('$this', color: textColor, maxLines: 1),
      padding: padding,
      trailing: checking
          ? MTCircularProgress(
              size: _connectionIndicatorSize,
              color: f2Color,
              strokeWidth: 3,
            )
          : MTCircle(
              color: connected
                  ? Colors.green
                  : error
                      ? warningColor
                      : f2Color,
              size: _connectionIndicatorSize),
      dividerIndent: (iconSize ?? P6) + P5,
      bottomDivider: bottomBorder,
      minHeight: standAlone ? null : 0,
      onTap: onTap,
      color: standAlone ? null : Colors.transparent,
    );
  }
}
