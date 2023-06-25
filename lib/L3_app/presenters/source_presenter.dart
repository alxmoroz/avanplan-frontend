// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/entities_extensions/ws_ext.dart';
import '../../main.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/mt_circle.dart';
import '../components/mt_list_tile.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';

Widget _iconForSourceType(SourceType? st) =>
    st != null && st.active ? Image.asset('assets/icons/${st.code}_icon.png', height: P2) : const MTCircle(size: P2, color: borderColor);

Widget iconTitleForSourceType(SourceType st) => Row(children: [_iconForSourceType(st), const SizedBox(width: P_2), MediumText('$st')]);

double get _connectionIndicatorSize => P;

extension SourcePresenter on Source {
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

    final textColor = (connected || isUnknown) ? null : lightGreyColor;

    return MTListTile(
      leading: _iconForSourceType(type),
      middle: NormalText('$this', color: textColor),
      padding: padding,
      trailing: checking
          ? SizedBox(
              height: _connectionIndicatorSize,
              width: _connectionIndicatorSize,
              child: CircularProgressIndicator(color: lightGreyColor.resolve(rootKey.currentContext!)),
            )
          : MTCircle(
              color: connected
                  ? Colors.green
                  : error
                      ? warningColor
                      : lightGreyColor,
              size: _connectionIndicatorSize),
      bottomDivider: bottomBorder,
      onTap: onTap,
      color: standAlone ? null : Colors.transparent,
    );
  }
}

extension TaskSourcePresenter on TaskSource {
  SourceType? get _typeForId => mainController.wsForId(wsId).sourceForId(sourceId)?.type;
  Widget go2SourceTitle({bool showSourceIcon = false}) => Row(
        children: [
          if (showSourceIcon) ...[
            _iconForSourceType(_typeForId),
            const SizedBox(width: P_2),
          ],
          NormalText(loc.task_go2source_title, color: mainColor),
          // const NormalText(' >', color: mainColor),
          const SizedBox(width: P_2),
          const LinkOutIcon(),
        ],
      );
}
