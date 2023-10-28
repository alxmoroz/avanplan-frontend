// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';
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
          if (ws.isMine) ...[const WSIcon(), const SizedBox(width: P_2)],
          if (ws.code.isNotEmpty && wsMainController.multiWS) BaseText.f2('${ws.code} ', maxLines: 1),
          Expanded(child: BaseText(ws.title, maxLines: 1)),
        ],
      ),
      subtitle: ws.description.isNotEmpty && wsMainController.multiWS ? SmallText(ws.description, maxLines: 2) : null,
      trailing: const ChevronIcon(),
      bottomDivider: bottomBorder,
      onTap: _showWorkspace,
    );
  }
}
