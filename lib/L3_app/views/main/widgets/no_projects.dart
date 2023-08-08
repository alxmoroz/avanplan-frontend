// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../views/my_projects/my_projects_view.dart';

class NoProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allClosed = mainController.allTasks.isNotEmpty;
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MTImage(allClosed ? ImageNames.ok : ImageNames.start),
          const SizedBox(height: P),
          if (allClosed)
            MTButton(
              leading: H2(loc.project_list_all_title, color: mainColor),
              middle: H2(loc.are_closed_suffix),
              onTap: () async => await Navigator.of(context).pushNamed(MyProjectsView.routeName),
            )
          else
            H2(loc.state_no_projects_hint, align: TextAlign.center),
          const SizedBox(height: P2),
          NormalText(
            loc.projects_add_hint_title,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P2),
            maxLines: 5,
          ),
          const SizedBox(height: P),
        ],
      ),
    );
  }
}
