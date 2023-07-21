// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/source_type.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/ws_ext.dart';
import '../../main.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/mt_circle.dart';
import '../components/mt_list_tile.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';

double get _connectionIndicatorSize => P;

extension SourceTypePresenter on SourceType {
  Widget get icon => active ? Image.asset('assets/icons/${code}_icon.png', height: P2) : const MTCircle(size: P2, color: borderColor);
  Widget get iconTitle => Row(children: [icon, const SizedBox(width: P_2), MediumText('$this')]);
}

extension SourcePresenter on Source {
  SourceType get type => refsController.typeForCode(typeCode);

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
      leading: type.icon,
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

extension TaskSourcePresenter on Task {
  Widget get go2SourceTitle {
    final _source = ws.sourceForId(taskSource?.sourceId);
    return Row(
      children: [
        const LinkIcon(),
        const SizedBox(width: P_3),
        NormalText(loc.task_go2source_title, color: mainColor),
        if (_source != null) ...[
          const SizedBox(width: P_3),
          _source.type.icon,
        ],
      ],
    );
  }
}
