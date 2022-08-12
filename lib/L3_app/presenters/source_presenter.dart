// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/source.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/mt_circle.dart';
import '../components/text_widgets.dart';

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

Widget sourceInfo(BuildContext context, Source s) => Row(children: [
      Column(children: [
        sourceTypeIcon(context, s.type),
        SizedBox(height: onePadding / 3),
        MTCircle(color: s.connected ? Colors.green : warningColor),
      ]),
      SizedBox(width: onePadding / 2),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        NormalText('${s.description.isEmpty ? s.type.title : s.description}'),
        SizedBox(height: onePadding / 6),
        SmallText(s.url),
      ]),
    ]);
