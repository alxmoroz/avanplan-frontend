// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/source_type.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_sources.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../../main.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';
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
  final st = await showMTDialog<SourceType?>(SourceTypeSelector((st) => Navigator.of(rootKey.currentContext!).pop(st)));
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
  final s = await editSourceDialog(ws, src, sType);
  if (s != null) {
    ws.updateSourceInList(s);
    if (!s.removed) {
      await s.checkConnection();
    }
    mainController.touchWorkspaces();
  }
  return s;
}

Future<Source?> editSourceDialog(Workspace ws, Source? src, SourceType? sType) async => await showMTDialog<Source?>(SourceEditView(ws, src, sType));

class SourceEditView extends StatefulWidget {
  const SourceEditView(this.ws, this.src, this.sType);
  final Workspace ws;
  final Source? src;
  final SourceType? sType;

  @override
  _SourceEditViewState createState() => _SourceEditViewState();
}

class _SourceEditViewState extends State<SourceEditView> {
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

  Widget get _form => ListView(
        shrinkWrap: true,
        children: [
          if (controller.showUrl) controller.tf(SourceFCode.url, first: true),
          if (controller.showUsername) controller.tf(SourceFCode.username, first: !controller.showUrl),
          if (controller.showUrl || controller.showUsername) const SizedBox(height: P3),
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
          controller.tf(SourceFCode.apiKey),
          controller.tf(SourceFCode.description),
          const SizedBox(height: P3),
          MTButton.main(
            titleText: loc.save_action_title,
            onTap: _canSave ? controller.save : null,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(
          middle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                if (_isNew) BaseText.medium(loc.source_title_new, padding: const EdgeInsets.only(right: P2)),
                controller.selectedType!.iconTitle(size: P4),
              ]),
              if (mainController.workspaces.length > 1) controller.ws.subtitleRow
            ],
          ),
          trailing: controller.canEdit
              ? MTButton.icon(
                  const DeleteIcon(),
                  onTap: () => controller.delete(context),
                  padding: const EdgeInsets.all(P2),
                )
              : null,
        ),
        topBarHeight: P8 + (mainController.workspaces.length > 1 ? P4 : 0),
        body: _form,
      ),
    );
  }
}
