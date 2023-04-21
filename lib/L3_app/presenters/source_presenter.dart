// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/components/mt_list_tile.dart';
import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/entities_extensions/ws_ext.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/icons_import.dart';
import '../components/icons_state.dart';
import '../components/mt_circle.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';

Widget _iconForSourceType(String? st) {
  switch (st) {
    case 'Redmine':
      return redmineIcon();
    case 'GitLab':
      return gitlabIcon();
    case 'Jira':
      return jiraIcon();
    default:
      return const NoInfoIcon();
  }
}

Widget iconTitleForSourceType(String st) => Row(children: [_iconForSourceType(st), const SizedBox(width: P_2), NormalText(st)]);

double get _connectionIndicatorSize => P;

extension SourcePresenter on Source {
  Widget listTile(
    BuildContext context, {
    EdgeInsets? padding,
    VoidCallback? onTap,
    bool bottomBorder = false,
  }) {
    final isUnknown = state == SrcState.unknown;
    final connected = state == SrcState.connected;
    final checking = state == SrcState.checking;
    final error = state == SrcState.error;

    final textColor = (connected || isUnknown) ? null : lightGreyColor;

    return MTListTile(
      leading: _iconForSourceType(type),
      middle: NormalText('$this', color: textColor),
      padding: padding ?? EdgeInsets.zero,
      trailing: checking
          ? SizedBox(
              height: _connectionIndicatorSize,
              width: _connectionIndicatorSize,
              child: CircularProgressIndicator(color: lightGreyColor.resolve(context)),
            )
          : MTCircle(
              color: connected
                  ? Colors.green
                  : error
                      ? warningColor
                      : lightGreyColor,
              size: _connectionIndicatorSize),
      bottomBorder: bottomBorder,
      onTap: onTap,
    );
  }
}

extension TaskSourcePresenter on TaskSource {
  String? get _typeForId => mainController.wsForId(wsId).sourceForId(sourceId)?.type;
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
