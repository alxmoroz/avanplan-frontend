// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/remote_source.dart';
import '../../L1_domain/entities/remote_source_type.dart';
import '../components/circle.dart';
import '../components/circular_progress.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/list_tile.dart';
import '../theme/colors.dart';
import '../theme/text.dart';
import '../views/app/services.dart';

extension RemoteSourceTypePresenter on RemoteSourceType {
  Widget icon({double? size}) => custom ? MailIcon(size: size ?? P4) : Image.asset('assets/icons/${code}_icon.png', height: size ?? P4);
  Widget iconTitle({double? size}) => Row(children: [icon(size: size), const SizedBox(width: P), BaseText('$this', maxLines: 1)]);
}

extension RemoteSourcePresenter on RemoteSource {
  RemoteSourceType get type => refsController.typeForCode(typeCode);
  double get _connectionIndicatorSize => P2;

  bool get connected => connectionState == RemoteSourceConnectionState.connected;

  bool get _isUnknown => connectionState == RemoteSourceConnectionState.unknown;
  bool get _checking => connectionState == RemoteSourceConnectionState.checking;
  bool get _error => connectionState == RemoteSourceConnectionState.error;

  Widget listTile({
    EdgeInsets? padding,
    VoidCallback? onTap,
    double? iconSize,
    bool bottomBorder = false,
    bool standAlone = true,
  }) {
    final textColor = (connected || _isUnknown) ? null : f2Color;

    return MTListTile(
      leading: type.icon(size: iconSize),
      middle: BaseText('$this', color: textColor, maxLines: 1),
      padding: padding,
      trailing: _checking
          ? MTCircularProgress(
              size: _connectionIndicatorSize,
              color: f2Color,
              strokeWidth: 3,
            )
          : MTCircle(
              color: connected
                  ? Colors.green
                  : _error
                      ? dangerColor
                      : f2Color,
              size: _connectionIndicatorSize),
      dividerIndent: P5 + (iconSize ?? DEF_TAPPABLE_ICON_SIZE),
      bottomDivider: bottomBorder,
      minHeight: standAlone ? null : 0,
      onTap: onTap,
      color: standAlone ? b3Color : Colors.transparent,
    );
  }
}
