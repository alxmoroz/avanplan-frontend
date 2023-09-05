// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';

class NoMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MTAdaptive.S(
      padding: const EdgeInsets.symmetric(horizontal: P3),
      force: true,
      child: ListView(
        shrinkWrap: true,
        children: [
          MTImage(ImageNames.emptyTeam.toString()),
          const SizedBox(height: P2),
          H2(loc.team_list_empty_title, align: TextAlign.center),
          const SizedBox(height: P),
          BaseText(loc.team_list_empty_hint, align: TextAlign.center),
        ],
      ),
    );
  }
}
