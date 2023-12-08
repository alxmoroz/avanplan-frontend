// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/button.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../projects/create_project_button.dart';
import '../../projects/create_project_controller.dart';
import '../../projects/projects_view.dart';

class NoProjects extends StatelessWidget {
  const NoProjects(this._controller);
  final CreateProjectController _controller;

  bool get allClosed => tasksMainController.projects.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            MTImage((allClosed ? ImageName.ok : ImageName.empty_tasks).name),
            const SizedBox(height: P3),
            if (allClosed)
              MTButton(
                leading: H2(loc.project_list_title, color: mainColor, maxLines: 1),
                middle: H2(loc.are_closed_suffix, maxLines: 1),
                onTap: () async => await ProjectsRouter().navigate(context),
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
            CreateProjectButton(_controller),
          ],
        ),
      ),
    );
  }
}
