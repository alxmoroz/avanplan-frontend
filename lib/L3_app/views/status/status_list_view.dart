// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/adaptive.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_statuses.dart';
import 'status_edit_dialog.dart';

class WorkspaceStatusesView extends StatelessWidget {
  const WorkspaceStatusesView(this._wsId);
  final int _wsId;

  static String get routeName => '/workspace/statuses';
  static String title(int wsId) => '${wsMainController.wsForId(wsId)} - ${loc.status_list_title}';

  Workspace get _ws => wsMainController.wsForId(_wsId);

  Widget itemBuilder(BuildContext context, int index) {
    final status = _ws.statuses.elementAt(index);
    return MTListTile(
      titleText: '$status',
      subtitle: status.allProjects ? SmallText(loc.status_all_projects_label, maxLines: 1) : null,
      trailing: Row(
        children: [
          if (status.closed) ...[const DoneIcon(true, color: f2Color), const SizedBox(width: P)],
          const ChevronIcon(),
        ],
      ),
      loading: status.loading,
      bottomDivider: index < _ws.statuses.length - 1,
      onTap: () async => await statusEditDialog(status),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(
          context,
          middle: _ws.subPageTitle(loc.status_list_title),
          trailing: const SizedBox(width: P8),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTShadowed(
            topPaddingIndent: P,
            bottomShadow: true,
            child: MTAdaptive(
              child: ListView.builder(
                itemBuilder: itemBuilder,
                itemCount: _ws.statuses.length,
              ),
            ),
          ),
        ),
        bottomBar: MTButton.secondary(
          leading: const PlusIcon(),
          titleText: loc.status_create_action_title,
          onTap: () async => await statusEditDialog(Status(
            id: null,
            code: loc.status_code_placeholder,
            closed: false,
            allProjects: false,
            wsId: _wsId,
          )),
        ),
      ),
    );
  }
}
