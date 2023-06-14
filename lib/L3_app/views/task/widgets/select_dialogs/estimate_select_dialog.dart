// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_circle.dart';
import '../../../../components/mt_close_dialog_button.dart';
import '../../../../components/mt_dialog.dart';
import '../../../../components/mt_list_tile.dart';
import '../../../../components/navbar.dart';
import '../../../../extra/services.dart';

Future<int?> estimateSelectDialog(Workspace ws, int? selectedEstimate) async => await showMTDialog<int?>(EstimateSelectView(ws, selectedEstimate));

// TODO: сделать универсальный элемент для выбора значения — см. другие подобные диалоги

class EstimateSelectView extends StatelessWidget {
  const EstimateSelectView(this.ws, this.selectedEstimate);
  final Workspace ws;
  final int? selectedEstimate;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ws.estimateValues.indexWhere((e) => e.value == selectedEstimate);
    return MTDialog(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            navBar(
              context,
              title: loc.task_estimate_placeholder,
              leading: MTCloseDialogButton(),
              bgColor: backgroundColor,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: ws.estimateValues.length,
              itemBuilder: (_, int index) {
                final ev = ws.estimateValues[index];
                return MTListTile(
                  titleText: '$ev',
                  trailing: selectedIndex == index ? const MTCircle(size: P, color: mainColor) : null,
                  bottomDivider: index < ws.estimateValues.length - 1,
                  onTap: () => Navigator.of(context).pop(ev.value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
