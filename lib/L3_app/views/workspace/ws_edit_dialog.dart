// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../views/_base/loader_screen.dart';
import 'ws_controller.dart';

Future<Workspace?> editWS(Workspace ws) async => await showMTDialog<Workspace?>(_WSEditDialog(ws));

class _WSEditDialog extends StatefulWidget {
  const _WSEditDialog(this.ws);
  final Workspace ws;

  @override
  State<StatefulWidget> createState() => _WSEditDialogState();
}

class _WSEditDialogState extends State<_WSEditDialog> {
  late final WSController controller;

  bool get canSave => controller.validated;

  @override
  void initState() {
    controller = WSController(widget.ws);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.loading
          ? LoaderScreen(controller, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.workspace_title),
              body: ListView(
                shrinkWrap: true,
                children: [
                  for (final code in [WSFCode.code, WSFCode.title, WSFCode.description]) controller.tf(code),
                  const SizedBox(height: P3),
                  MTButton.main(
                    titleText: loc.save_action_title,
                    onTap: canSave ? () => controller.save : null,
                  ),
                  if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                ],
              ),
            ),
    );
  }
}
