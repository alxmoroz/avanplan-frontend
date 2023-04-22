// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/source.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../components/colors.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';

extension WSPresenter on Workspace {
  List<Source> get sortedSources => sources.sorted((s1, s2) => s1.url.compareTo(s2.url));
  List<User> get sortedUsers => users.sorted((u1, u2) => compareNatural('$u1', '$u2'));

  Widget get subtitleRow => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SmallText('[$code] ', color: lightGreyColor),
          LightText('$this'),
        ],
      );

  Widget subPageTitle(String pageTitle) => Column(
        children: [
          MediumText(pageTitle),
          if (mainController.workspaces.length > 1) subtitleRow,
        ],
      );
}
