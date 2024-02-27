// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/button.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/images.dart';
import '../../../components/text.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../projects/create_project_button.dart';
import '../../projects/create_project_controller.dart';
import '../../projects/projects_view.dart';

class NoTasks extends StatelessWidget {
  const NoTasks(this._controller, {super.key});
  final CreateProjectController _controller;

  bool get _hasOpenedProjects => tasksMainController.hasOpenedProjects;
  bool get _hasOpenedTasks => tasksMainController.hasOpenedTasks;
  bool get _canPlan => _hasOpenedProjects || _hasOpenedTasks;
  bool get _isAllProjectsClosed => tasksMainController.isAllProjectsClosed;
  bool get _freshStart => !_hasOpenedProjects && !_hasOpenedTasks;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Align(
        alignment: _freshStart ? Alignment.bottomCenter : Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: P3),
            MTImage((_freshStart
                    ? ImageName.ok_blue
                    : _isAllProjectsClosed
                        ? ImageName.ok
                        : ImageName.empty_tasks)
                .name),
            const SizedBox(height: P3),
            H2(_freshStart ? loc.lets_get_started : loc.task_list_empty_title, align: TextAlign.center),
            const SizedBox(height: P3),
            BaseText(
              _freshStart ? loc.project_list_empty_hint : loc.task_list_schedule_hint,
              align: TextAlign.center,
              padding: const EdgeInsets.symmetric(horizontal: P6),
              maxLines: 5,
            ),
            if (_canPlan)
              MTButton.secondary(
                titleText: loc.task_list_schedule_action_title,
                margin: const EdgeInsets.only(top: P3),
                onTap: () => MTRouter.navigate(ProjectsRouter, context),
              ),
            if (!_hasOpenedProjects) ...[
              const SizedBox(height: P3),
              CreateProjectButton(_controller, type: ButtonType.main),
            ],
            if (_freshStart) ...[
              const SizedBox(height: P7),
              BaseText(
                loc.my_tasks_add_action_hint,
                align: TextAlign.center,
                maxLines: 2,
              ),
              const SizedBox(height: P2),
              const LocalImportIcon(size: P6, color: f2Color),
              const SizedBox(height: P3),
            ]
          ],
        ),
      ),
    );
  }
}
