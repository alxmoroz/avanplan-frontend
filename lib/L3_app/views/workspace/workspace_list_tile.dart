// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/usecases/ws_ext_tariffs.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/tariff_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import 'workspace_view.dart';

class WorkspaceListTile extends StatelessWidget {
  const WorkspaceListTile(this.ws);
  final Workspace ws;

  Future _showWorkspace(BuildContext context) async => await Navigator.of(context).pushNamed(WorkspaceView.routeName, arguments: ws);

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      middle: NormalText(ws.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (ws.description.isNotEmpty) SmallText(ws.description, padding: const EdgeInsets.only(bottom: P_2), maxLines: 2),
          SmallText(ws.me!.rolesStr, color: greyColor),
          SmallText("${loc.tariff_title}: ${ws.activeTariffs.map((t) => t.title).join(',')}", color: greyColor),
        ],
      ),
      trailing: const ChevronIcon(),
      onTap: () => _showWorkspace(context),
    );
  }
}
