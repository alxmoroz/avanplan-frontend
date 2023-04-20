// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'workspace_edit_controller.dart';

Future<Workspace?> editWSDialog() async {
  return await showModalBottomSheet<Workspace?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const MTBottomSheet(WSEditView()),
  );
}

class WSEditView extends StatefulWidget {
  const WSEditView();

  @override
  _WSEditViewState createState() => _WSEditViewState();
}

class _WSEditViewState extends State<WSEditView> {
  late final WorkspaceEditController controller;

  bool get canSave => controller.validated;

  @override
  void initState() {
    controller = WorkspaceEditController();
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

  Widget form(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          for (final code in ['code', 'title', 'description']) textFieldForCode(code),
          const SizedBox(height: P2),
          MTButton.outlined(
            titleText: loc.save_action_title,
            onTap: canSave ? controller.save : null,
          ),
          const SizedBox(height: P2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form(context)),
      ),
    );
  }
}
