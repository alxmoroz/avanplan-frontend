// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../my_projects/my_projects_view.dart';
import '../../controllers/create_project_controller.dart';
import '../create/create_project_button.dart';
import '../create/import_project_button.dart';

class NoProjects extends StatelessWidget {
  const NoProjects(this._controller);
  final CreateProjectController _controller;

  @override
  Widget build(BuildContext context) {
    final allClosed = tasksMainController.projects.isNotEmpty;
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          MTImage((allClosed ? ImageName.ok : ImageName.empty_tasks).name),
          const SizedBox(height: P3),
          if (allClosed)
            MTButton(
              leading: H2(loc.project_list_title, color: mainColor),
              middle: H2(loc.are_closed_suffix),
              onTap: () async => await Navigator.of(context).pushNamed(MyProjectsView.routeName),
            )
          else
            H2(loc.project_list_empty_title, align: TextAlign.center),
          const SizedBox(height: P3),
          BaseText(
            loc.project_list_empty_hint,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P6),
            maxLines: 5,
          ),
          const SizedBox(height: P3),
          ImportProjectButton(_controller),
          const SizedBox(height: P3),
          CreateProjectButton(_controller),
        ],
      ),
    );
  }
}
