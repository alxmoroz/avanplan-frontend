// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/source.dart';
import '../components/icons.dart';

Widget sourceIcon(BuildContext context, Source s) {
  Widget icon = noInfoStateIcon(context);
  switch (s.type.title) {
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
