// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/components/mt_toolbar.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../extra/services.dart';
import 'workspace_edit_controller.dart';

Future<Workspace?> editWSDialog(Workspace ws) async => await showMTDialog<Workspace?>(WSEditView(ws));

class WSEditView extends StatefulWidget {
  const WSEditView(this.ws);
  final Workspace ws;

  @override
  _WSEditViewState createState() => _WSEditViewState();
}

class _WSEditViewState extends State<WSEditView> {
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
          const SizedBox(height: P2),
          MTButton.main(
            titleText: loc.save_action_title,
            onTap: canSave ? controller.save : null,
          ),
          const SizedBox(height: P),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.workspace_title),
      body: _form,
    );
  }
}
