// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
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

  Widget textFieldForCode(String code) {
    final tfa = controller.tfAnnoForCode(code);

    return MTTextField(
      controller: controller.teControllers[code],
      label: tfa.label,
      obscureText: code == 'password',
      maxLines: 1,
      capitalization: TextCapitalization.none,
    );
  }

  Widget get form => ListView(
        shrinkWrap: true,
        children: [
          for (final code in ['code', 'title', 'description']) textFieldForCode(code),
          const SizedBox(height: P2),
          MTButton.main(
            titleText: loc.save_action_title,
            onTap: canSave ? controller.save : null,
          ),
          const SizedBox(height: P2),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: navBar(
        context,
        leading: MTCloseButton(),
        bgColor: backgroundColor,
      ),
      body: SafeArea(
        top: false,
        child: Observer(
          builder: (_) => form,
        ),
      ),
    );
  }
}
