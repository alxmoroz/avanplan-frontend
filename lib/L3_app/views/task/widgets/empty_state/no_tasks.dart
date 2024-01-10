// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_feature_sets.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import '../local_transfer/local_import_dialog.dart';

class NoTasks extends StatelessWidget {
  const NoTasks(this._controller, {super.key, this.overview = false});
  final TaskController _controller;
  final bool overview;

  Task? get _parent => _controller.task;
  bool get _isProjectWGoals => _parent!.isProject && _parent!.hfsGoals;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _parent != null
          ? Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  MTImage(
                    overview
                        ? _isProjectWGoals
                            ? ImageName.goal.name
                            : ImageName.goal_done.name
                        : ImageName.empty_tasks.name,
                  ),
                  H2(
                    overview
                        ? _isProjectWGoals
                            ? loc.recommendation_add_goals_title
                            : loc.task_list_empty_overview_title
                        : _isProjectWGoals
                            ? loc.goal_list_empty_title
                            : loc.task_list_empty_title,
                    align: TextAlign.center,
                    padding: const EdgeInsets.all(P3),
                  ),
                  if (_parent!.canLocalImport || _parent!.canCreate) ...[
                    BaseText(
                      _parent!.canLocalImport
                          ? loc.task_list_empty_local_import_hint
                          : overview
                              ? _isProjectWGoals
                                  ? loc.recommendation_add_goals_hint
                                  : loc.recommendation_add_tasks_hint
                              : _isProjectWGoals
                                  ? loc.goal_list_empty_hint
                                  : loc.task_list_empty_hint,
                      align: TextAlign.center,
                      padding: const EdgeInsets.symmetric(horizontal: P6),
                    ),
                    if (_parent!.canLocalImport)
                      MTButton.secondary(
                        margin: const EdgeInsets.only(top: P3),
                        leading: const LocalImportIcon(),
                        titleText: loc.task_transfer_import_action_title,
                        onTap: () => localImportDialog(_controller),
                      ),
                    if (_parent!.canCreate) ...[
                      const SizedBox(height: P3),
                      CreateTaskButton(_controller, compact: false, type: ButtonType.main),
                    ],
                  ],
                  // newSubtaskTitle
                ],
              ),
            )
          : Container(),
    );
  }
}
