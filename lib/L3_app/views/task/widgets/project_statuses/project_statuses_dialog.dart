// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_status.dart';
import '../../controllers/task_controller.dart';
import 'project_status_edit_dialog.dart';

Future showProjectStatusesDialog(TaskController controller) async => await showMTDialog<void>(ProjectStatusesDialog(controller));

class ProjectStatusesDialog extends StatelessWidget {
  const ProjectStatusesDialog(this._controller);
  final TaskController _controller;

  Task get _project => _controller.task;

  Widget itemBuilder(BuildContext context, int index) {
    final status = _project.statuses.elementAt(index);
    return MTListTile(
      titleText: '$status',
      subtitle: status.description.isNotEmpty ? SmallText(status.description, maxLines: 2) : null,
      trailing: Row(
        children: [
          if (status.closed) ...[const DoneIcon(true, color: f2Color), const SizedBox(width: P)],
          const ChevronIcon(),
        ],
      ),
      loading: status.loading,
      bottomDivider: index < _project.statuses.length - 1,
      onTap: () async => await projectStatusEditDialog(status, _project),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(titleText: loc.status_list_title),
        body: MTShadowed(
          topPaddingIndent: P,
          bottomShadow: true,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: itemBuilder,
            itemCount: _project.statuses.length,
          ),
        ),
        bottomBar: MTButton.secondary(
          leading: const PlusIcon(),
          titleText: loc.status_create_action_title,
          onTap: () async => await projectStatusEditDialog(
            ProjectStatus(
              id: null,
              title: loc.status_code_placeholder,
              closed: false,
              position: _project.statuses.length,
            ),
            _project,
          ),
        ),
      ),
    );
  }
}
