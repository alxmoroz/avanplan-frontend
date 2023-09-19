// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../views/my_projects/my_projects_view.dart';

class NoProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allClosed = mainController.projects.isNotEmpty;
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: P),
          MTImage((allClosed ? ImageName.ok : ImageName.start).name),
          const SizedBox(height: P3),
          if (allClosed)
            MTButton(
              leading: H2(loc.project_list_title, color: mainColor),
              middle: H2(loc.are_closed_suffix),
              onTap: () async => await Navigator.of(context).pushNamed(MyProjectsView.routeName),
            )
          else
            H2(loc.state_no_projects_hint, align: TextAlign.center),
          const SizedBox(height: P4),
          BaseText(
            loc.projects_add_hint_title,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P3),
            maxLines: 5,
          ),
          const SizedBox(height: P2),
        ],
      ),
    );
  }
}
