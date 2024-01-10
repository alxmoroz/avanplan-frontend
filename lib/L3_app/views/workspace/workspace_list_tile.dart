// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';

class WorkspaceListTile extends StatelessWidget {
  const WorkspaceListTile(
    this.ws, {
    super.key,
    required this.bottomDivider,
    this.onTap,
  });
  final Workspace ws;
  final bool bottomDivider;
  final Function()? onTap;

  bool get _disabled => onTap == null;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: ws.isMine ? const WSIconHome() : WSIconPublic(color: _disabled ? f2Color : null),
      dividerIndent: P11,
      middle: Row(children: [
        Expanded(child: BaseText(ws.title, maxLines: 1)),
        if (ws.code.isNotEmpty && wsMainController.multiWS) SmallText(ws.code, maxLines: 1, color: f3Color),
        _disabled ? const PrivacyIcon(color: f2Color, size: P4) : const ChevronIcon(),
      ]),
      subtitle: ws.description.isNotEmpty ? SmallText(ws.description, maxLines: 2) : null,
      bottomDivider: bottomDivider,
      onTap: onTap,
    );
  }
}
