// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/tariff.dart';
import 'workspace_view.dart';

class WorkspaceListTile extends StatelessWidget {
  const WorkspaceListTile(this.ws, {required this.bottomBorder});
  final Workspace ws;
  final bool bottomBorder;

  Future _showWorkspace() async {
    await Navigator.of(rootKey.currentContext!).pushNamed(WorkspaceView.routeName, arguments: ws.id);
  }

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      middle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (ws.code.isNotEmpty) BaseText.f2('[${ws.code}] '),
          Expanded(child: BaseText(ws.title)),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (ws.description.isNotEmpty) SmallText(ws.description, padding: const EdgeInsets.only(bottom: P), maxLines: 2),
          SmallText('${loc.tariff_title}: ${ws.invoice.tariff.title}'),
        ],
      ),
      trailing: const ChevronIcon(),
      bottomDivider: bottomBorder,
      onTap: _showWorkspace,
    );
  }
}
