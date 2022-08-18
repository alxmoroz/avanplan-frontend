// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/task.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/mt_circle.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';

Widget sourceTypeIcon(BuildContext context, SourceType st) {
  Widget icon = noInfoStateIcon(context);
  switch (st.title) {
    case 'Redmine':
      icon = redmineIcon();
      break;
    case 'GitLab':
      icon = gitlabIcon();
      break;
    case 'Jira':
      icon = jiraIcon();
      break;
  }
  return icon;
}

Widget sourceInfo(BuildContext context, Source s) {
  final isUnknown = s.state == SrcState.unknown;
  final connected = s.state == SrcState.connected;
  final textColor = connected ? null : lightGreyColor;
  return Row(children: [
    Column(children: [
      sourceTypeIcon(context, s.type),
      SizedBox(height: onePadding / 3),
      isUnknown ? connectingIcon(context) : MTCircle(color: connected ? Colors.green : warningColor),
    ]),
    SizedBox(width: onePadding / 2),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      NormalText('${s.description.isEmpty ? s.type.title : s.description}', color: textColor),
      SizedBox(height: onePadding / 6),
      SmallText(s.url, color: textColor),
    ]),
  ]);
}

Widget taskSourceGotoTitle(BuildContext context, Task task) => Row(
      children: [
        sourceTypeIcon(context, task.taskSource!.source.type),
        SizedBox(width: onePadding / 3),
        NormalText(loc.task_goto_source_title, color: mainColor),
        SizedBox(width: onePadding / 3),
        linkOutIcon(context),
      ],
    );
