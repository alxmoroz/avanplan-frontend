// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../../usecases/ws_actions.dart';
import '../app/services.dart';

class WSListTile extends StatelessWidget {
  const WSListTile(
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
      leading: ws.isMine ? const HomeIcon() : WSPublicIcon(color: _disabled ? f2Color : mainColor),
      dividerIndent: P5 + DEF_TAPPABLE_ICON_SIZE,
      middle: Row(children: [
        Expanded(child: BaseText(ws.title, maxLines: 1)),
        if (ws.code.isNotEmpty && wsMainController.multiWS) SmallText(ws.code, maxLines: 1, color: f3Color),
        _disabled
            ? const PrivacyIcon(color: f2Color, size: P4)
            : kIsWeb
                ? const SizedBox()
                : const ChevronIcon(),
      ]),
      subtitle: ws.description.isNotEmpty ? SmallText(ws.description, maxLines: 2) : null,
      bottomDivider: bottomDivider,
      onTap: onTap,
    );
  }
}
