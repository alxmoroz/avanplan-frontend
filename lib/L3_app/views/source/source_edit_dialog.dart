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
import '../../components/colors.dart';
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
    remoteSourcesUC.requestType(sType, ws.id!);

    if (sType.custom) {
      await _emailUsCustomImport();
    } else {
      await showMTAlertDialog(
        imageName: ImageName.empty_sources.name,
        title: loc.source_type_request_dialog_title('$sType'),
        description: loc.source_type_request_dialog_description,
        actions: [
          MTDialogAction(title: loc.action_email_us_title, type: ButtonType.main, onTap: _emailUsCustomImport),
          MTDialogAction(title: loc.later, type: ButtonType.text),
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
  late final SourceEditController _sec;

  bool get _isNew => _sec.source == null;
  bool get _canSave => _sec.validated;
  String get _sourceCode => _sec.selectedType != null ? _sec.selectedType!.code : '';
  String get _sourceEditHelperAddress => '$docsPath/import/$_sourceCode';

  @override
  void initState() {
    _sec = SourceEditController(widget.ws, widget.src?.id, widget.sType);
    _sec.stopLoading();
    super.initState();
  }

  @override
  void dispose() {
    _sec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _sec.loading
          ? LoaderScreen(_sec, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(
                middle: Row(mainAxisSize: MainAxisSize.min, children: [
                  if (wsMainController.multiWS) BaseText.f3('${_sec.ws.codeStr} ', maxLines: 1),
                  if (_isNew) BaseText.medium('${loc.source_title_new} ', maxLines: 1, color: f2Color),
                  _sec.selectedType!.iconTitle(size: P4),
                ]),
                trailing: _sec.canEdit
                    ? MTButton.icon(
                        const DeleteIcon(),
                        onTap: () => _sec.delete(context),
                        padding: const EdgeInsets.all(P2),
                      )
                    : null,
              ),
              body: ListView(
                shrinkWrap: true,
                children: [
                  if (_sec.showUrl) _sec.tf(SourceFCode.url, first: true),
                  if (_sec.showUsername) _sec.tf(SourceFCode.username, first: !_sec.showUrl),
                  if (_sec.showUrl || _sec.showUsername) const SizedBox(height: P3),
                  if (_sec.selectedType?.hasApiKey == true) ...[
                    _sec.selectedType?.isTrello == true
                        ? MTButton(
                            titleText: loc.source_get_token_action,
                            trailing: const LinkOutIcon(),
                            onTap: _sec.getTrelloToken,
                          )
                        : MTButton(
                            titleText: loc.source_get_token_help_action,
                            trailing: const LinkOutIcon(),
                            onTap: () => launchUrlString(_sourceEditHelperAddress),
                          ),
                    _sec.tf(SourceFCode.apiKey),
                  ],
                  _sec.tf(SourceFCode.description),
                  MTButton.main(
                    titleText: loc.action_save_title,
                    margin: const EdgeInsets.only(top: P3),
                    onTap: _canSave ? () => _sec.save(context) : null,
                  ),
                ],
              ),
              forceBottomPadding: true,
              hasKBInput: true,
            ),
    );
  }
}
