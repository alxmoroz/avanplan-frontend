// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'workspace_edit_controller.dart';

Future<Workspace?> editWS(Workspace ws) async => await showMTDialog<Workspace?>(_WSEditDialog(ws));

class _WSEditDialog extends StatefulWidget {
  const _WSEditDialog(this.ws);
  final Workspace ws;

  @override
  State<StatefulWidget> createState() => _WSEditDialogState();
}

class _WSEditDialogState extends State<_WSEditDialog> {
  late final WorkspaceEditController controller;

  bool get canSave => controller.validated;

  @override
  void initState() {
    controller = WorkspaceEditController(widget.ws);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget get _form => ListView(
        shrinkWrap: true,
        children: [
          for (final code in [WSFCode.code, WSFCode.title, WSFCode.description]) controller.tf(code),
          MTButton.main(
            titleText: loc.save_action_title,
            margin: const EdgeInsets.symmetric(vertical: P3),
            onTap: canSave ? controller.save : null,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.workspace_title),
      body: _form,
    );
  }
}
