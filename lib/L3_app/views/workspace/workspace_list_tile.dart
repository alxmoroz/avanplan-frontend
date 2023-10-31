// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/colors_base.dart';
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
      dividerIndent: P * 11,
      leading: ws.isMine ? const WSIconHome() : const WSIconPublic(),
      middle: Row(children: [
        Expanded(child: BaseText(ws.title, maxLines: 1)),
        if (ws.code.isNotEmpty && wsMainController.multiWS) SmallText(ws.code, maxLines: 1, color: f3Color),
        const ChevronIcon(),
      ]),
      subtitle: ws.description.isNotEmpty ? SmallText(ws.description, maxLines: 2) : null,
      bottomDivider: bottomBorder,
      onTap: _showWorkspace,
    );
  }
}
