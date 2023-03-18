// Copyright (c) 2022. Alexandr Moroz

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

Widget iconForSourceType(String? st) {
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

Widget iconTitleForSourceType(String st) => Row(children: [iconForSourceType(st), const SizedBox(width: P_2), NormalText(st)]);

double get _connectionIndicatorSize => P;

extension SourcePresenter on Source {
  Widget info(BuildContext context) {
    final isUnknown = state == SrcState.unknown;
    final connected = state == SrcState.connected;
    final checking = state == SrcState.checking;
    final error = state == SrcState.error;

    final textColor = (connected || isUnknown) ? null : lightGreyColor;
    return Row(children: [
      iconForSourceType(type),
      const SizedBox(width: P_2),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          NormalText('$this', color: textColor),
          SmallText(url, color: textColor),
        ]),
      ),
      checking
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
    ]);
  }
}

extension TaskSourcePresenter on TaskSource {
  String? get _typeForId => mainController.wsForId(wsId)?.sourceForId(sourceId)?.type;
  Widget go2SourceTitle({bool showSourceIcon = false}) => Row(
        children: [
          if (showSourceIcon) ...[
            iconForSourceType(_typeForId),
            const SizedBox(width: P_2),
          ],
          NormalText(loc.task_go2source_title, color: mainColor),
          // const NormalText(' >', color: mainColor),
          const SizedBox(width: P_2),
          const LinkOutIcon(),
        ],
      );
}
