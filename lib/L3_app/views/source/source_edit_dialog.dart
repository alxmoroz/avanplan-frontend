// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/remote_source.dart';
import '../../../L1_domain/entities/remote_source_type.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/remote_source.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/remote_source.dart';
import '../../presenters/workspace.dart';
import '../../usecases/communications.dart';
import '../../usecases/source.dart';
import '../../views/_base/loader_screen.dart';
import 'source_edit_controller.dart';
import 'source_type_selector.dart';

Future startAddSource(Workspace ws) async {
  final st = await selectSourceType();
  if (st != null) {
    await addSource(ws, sType: st);
  }
}

Future _emailUsCustomImport() async => await mailUs(subject: loc.import_custom_request_mail_subject, text: loc.import_custom_request_mail_body_text);

Future<RemoteSource?> addSource(Workspace ws, {required RemoteSourceType sType}) async {
  RemoteSource? s;
  if (sType.active) {
    s = await editSource(ws, sType: sType);
  } else {
    wsSourcesUC.requestType(sType, ws.id!);

    if (sType.custom) {
      await _emailUsCustomImport();
    } else {
      await showMTAlertDialog(
        imageName: ImageName.empty_sources.name,
        title: loc.source_type_request_dialog_title('$sType'),
        description: loc.source_type_request_dialog_description,
        actions: [
          MTDialogAction(title: loc.later),
          MTDialogAction(title: loc.action_email_us_title, type: ButtonType.main, onTap: _emailUsCustomImport),
        ],
      );
    }
  }
  return s;
}

Future<RemoteSource?> editSource(Workspace ws, {RemoteSource? src, RemoteSourceType? sType}) async {
  final s = await sourceEditDialog(ws, src, sType);
  if (s != null) {
    ws.updateRemoteSourceInList(s);
    if (!s.removed) {
      await s.checkConnection();
    }
    wsMainController.refreshUI();
  }
  return s;
}

Future<RemoteSource?> sourceEditDialog(Workspace ws, RemoteSource? src, RemoteSourceType? sType) async =>
    await showMTDialog<RemoteSource?>(_SourceEditDialog(ws, src, sType));

class _SourceEditDialog extends StatefulWidget {
  const _SourceEditDialog(this.ws, this.src, this.sType);
  final Workspace ws;
  final RemoteSource? src;
  final RemoteSourceType? sType;

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
    controller.stopLoading();
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
                  if (controller.selectedType?.hasApiKey == true) ...[
                    controller.selectedType?.isTrello == true
                        ? MTButton.secondary(
                            titleText: loc.source_get_token_action,
                            onTap: controller.getTrelloToken,
                          )
                        : MTButton.secondary(
                            titleText: loc.source_get_token_help_action,
                            onTap: () => launchUrlString(_sourceEditHelperAddress),
                          ),
                    controller.tf(SourceFCode.apiKey),
                  ],
                  controller.tf(SourceFCode.description),
                  const SizedBox(height: P3),
                  MTButton.main(
                    titleText: loc.action_save_title,
                    onTap: _canSave ? () => controller.save(context) : null,
                  ),
                  if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                ],
              ),
            ),
    );
  }
}
