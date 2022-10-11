// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task_source.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/mt_circle.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';

extension SourceTypePresenter on SourceType {
  Widget icon(BuildContext context) {
    switch (title) {
      case 'Redmine':
        return redmineIcon();
      case 'GitLab':
        return gitlabIcon();
      case 'Jira':
        return jiraIcon();
      default:
        return noInfoStateIcon(context);
    }
  }
}

extension SourcePresenter on Source {
  Widget info(BuildContext context) {
    final isUnknown = state == SrcState.unknown;
    final connected = state == SrcState.connected;
    final textColor = connected ? null : lightGreyColor;
    return Row(children: [
      type.icon(context),
      SizedBox(width: onePadding / 2),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          NormalText('${description.isEmpty ? type.title : description}', color: textColor),
          SmallText(url, color: textColor),
        ]),
      ),
      isUnknown ? connectingIcon(context) : MTCircle(color: connected ? Colors.green : warningColor),
    ]);
  }
}

extension TaskSourcePresenter on TaskSource {
  Widget go2SourceTitle(BuildContext context, {bool showSourceIcon = false}) => Row(
        children: [
          if (showSourceIcon) ...[
            source.type.icon(context),
            SizedBox(width: onePadding / 2),
          ],
          NormalText(loc.task_go2source_title, color: mainColor),
          // const NormalText(' >', color: mainColor),
          SizedBox(width: onePadding / 2),
          linkOutIcon(context),
        ],
      );
}
