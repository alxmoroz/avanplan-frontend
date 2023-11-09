// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
import '../../controllers/project_statuses_controller.dart';

Future showProjectStatusesDialog(ProjectStatusesController controller) async => await showMTDialog<void>(ProjectStatusesDialog(controller));

class ProjectStatusesDialog extends StatelessWidget {
  const ProjectStatusesDialog(this._controller);
  final ProjectStatusesController _controller;

  Widget itemBuilder(BuildContext context, int index) {
    final status = _controller.sortedStatuses.elementAt(index);
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
      bottomDivider: index < _controller.sortedStatuses.length - 1,
      onTap: () => _controller.edit(status),
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
            itemCount: _controller.sortedStatuses.length,
          ),
        ),
        bottomBar: MTButton.secondary(
          leading: const PlusIcon(),
          titleText: loc.status_create_action_title,
          onTap: _controller.create,
        ),
      ),
    );
  }
}
