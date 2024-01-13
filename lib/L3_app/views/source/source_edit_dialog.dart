// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/communications.dart';
import '../../usecases/source.dart';
import 'source_edit_controller.dart';
import 'source_type_selector.dart';

Future startAddSource(Workspace ws) async {
  final st = await selectSourceType();
  if (st != null) {
    await addSource(ws, sType: st);
  }
}

Future<Source?> addSource(Workspace ws, {required SourceType sType}) async {
  Source? s;
  if (sType.active) {
    s = await editSource(ws, sType: sType);
  } else {
    sourceUC.requestSourceType(sType);

    if (sType.custom) {
      await mailUs(subject: loc.import_custom_request_mail_subject, text: loc.import_custom_request_mail_body_text);
    } else {
      await showMTAlertDialog(
        loc.source_type_unavailable_title('$sType'),
        description: loc.source_type_unavailable_hint,
        simple: true,
        actions: [MTADialogAction(title: loc.ok, type: MTActionType.isDefault, result: true)],
      );
    }
  }
  return s;
}

Future<Source?> editSource(Workspace ws, {Source? src, SourceType? sType}) async {
  final s = await sourceEditDialog(ws, src, sType);
  if (s != null) {
    ws.updateSourceInList(s);
    if (!s.removed) {
      await s.checkConnection();
    }
    wsMainController.refreshWorkspaces();
  }
  return s;
}

Future<Source?> sourceEditDialog(Workspace ws, Source? src, SourceType? sType) async =>
    await showMTDialog<Source?>(_SourceEditDialog(ws, src, sType));

class _SourceEditDialog extends StatefulWidget {
  const _SourceEditDialog(this.ws, this.src, this.sType);
  final Workspace ws;
  final Source? src;
  final SourceType? sType;

  @override
  State<StatefulWidget> createState() => _SourceEditDialogState();
}

class _SourceEditDialogState extends State<_SourceEditDialog> {
  late final SourceEditController controller;

  bool get _isNew => controller.source == null;
  bool get _canSave => controller.validated;
  String get _sourceCode => controller.selectedType != null ? controller.selectedType!.code : '';
  String get _sourceEditHelperAddress => '$docsPath/import/$_sourceCode';

  @override
  void initState() {
    controller = SourceEditController(widget.ws, widget.src?.id, widget.sType);
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
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          middle: Row(mainAxisSize: MainAxisSize.min, children: [
            if (wsMainController.multiWS) BaseText.f3('${controller.ws.codeStr} ', maxLines: 1),
            if (_isNew) BaseText('${loc.source_title_new} ', maxLines: 1),
            controller.selectedType!.iconTitle(size: P4),
          ]),
          trailing: controller.canEdit
              ? MTButton.icon(
                  const DeleteIcon(),
                  onTap: () => controller.delete(context),
                  padding: const EdgeInsets.all(P2),
                )
              : null,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            if (controller.showUrl) controller.tf(SourceFCode.url, first: true),
            if (controller.showUsername) controller.tf(SourceFCode.username, first: !controller.showUrl),
            if (controller.showUrl || controller.showUsername) const SizedBox(height: P3),
            if (controller.selectedType?.isTrelloJson == false)
              controller.selectedType?.isTrello == true
                  ? MTButton.secondary(
                      titleText: loc.source_get_token_action,
                      trailing: const LinkOutIcon(),
                      onTap: controller.getTrelloToken,
                    )
                  : MTButton.secondary(
                      titleText: loc.source_get_token_help_action,
                      trailing: const LinkOutIcon(),
                      onTap: () => launchUrlString(_sourceEditHelperAddress),
                    ),
            if (controller.selectedType?.isTrelloJson == false) controller.tf(SourceFCode.apiKey),
            controller.tf(SourceFCode.description),
            MTButton.main(
              titleText: loc.save_action_title,
              margin: const EdgeInsets.symmetric(vertical: P3),
              onTap: _canSave ? controller.save : null,
            ),
          ],
        ),
      ),
    );
  }
}
