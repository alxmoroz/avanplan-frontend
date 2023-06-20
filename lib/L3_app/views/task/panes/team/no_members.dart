// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';

class NoMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: P),
      child: ListView(
        shrinkWrap: true,
        children: [
          MTImage(ImageNames.empty_team.toString()),
          const SizedBox(height: P),
          H3(loc.team_list_empty_title, align: TextAlign.center),
          const SizedBox(height: P),
          NormalText(loc.team_list_empty_hint, align: TextAlign.center),
        ],
      ),
    );
  }
}
