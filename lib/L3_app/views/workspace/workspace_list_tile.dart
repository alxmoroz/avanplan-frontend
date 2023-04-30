// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/tariff_presenter.dart';
import 'workspace_view.dart';

class WorkspaceListTile extends StatelessWidget {
  const WorkspaceListTile(this.ws);
  final Workspace ws;

  Future _showWorkspace() async {
    await Navigator.of(rootKey.currentContext!).pushNamed(WorkspaceView.routeName, arguments: ws);
  }

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      middle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (ws.code.isNotEmpty) SmallText('[${ws.code}] ', color: greyColor),
          Expanded(child: NormalText(ws.title)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (ws.description.isNotEmpty) SmallText(ws.description, padding: const EdgeInsets.only(bottom: P_2), maxLines: 2),
          SmallText('${loc.tariff_title}: ${ws.invoice.tariff.title}', color: greyColor),
        ],
      ),
      trailing: const ChevronIcon(),
      onTap: _showWorkspace,
    );
  }
}
