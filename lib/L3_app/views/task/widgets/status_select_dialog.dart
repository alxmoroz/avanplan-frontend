// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/workspace.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_circle.dart';
import '../../../components/mt_close_button.dart';
import '../../../components/mt_dialog.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/navbar.dart';
import '../../../extra/services.dart';

Future<int?> statusSelectDialog(Workspace ws, int? selectedId) async => await showMTDialog<int?>(StatusSelectView(ws, selectedId));

class StatusSelectView extends StatelessWidget {
  const StatusSelectView(this.ws, this.selectedId);
  final Workspace ws;
  final int? selectedId;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ws.statuses.indexWhere((s) => s.id == selectedId);
    return MTDialog(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            navBar(
              context,
              title: loc.task_status_placeholder,
              leading: MTCloseButton(),
              bgColor: backgroundColor,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: ws.statuses.length,
              itemBuilder: (_, int index) {
                final s = ws.statuses[index];
                return MTListTile(
                  titleText: '$s',
                  trailing: selectedIndex == index ? const MTCircle(size: P, color: mainColor) : null,
                  bottomDivider: index < ws.statuses.length - 1,
                  onTap: () => Navigator.of(context).pop(s.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
