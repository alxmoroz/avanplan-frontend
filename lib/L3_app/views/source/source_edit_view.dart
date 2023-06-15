// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../../main.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_text_field.dart';
import '../../components/mt_toolbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/source_ext.dart';
import '../../usecases/ws_ext_sources.dart';
import 'source_edit_controller.dart';
import 'source_type_selector.dart';

Future startAddSource(Workspace ws) async {
  final st = await showMTDialog<String?>(SourceTypeSelector((st) => Navigator.of(rootKey.currentContext!).pop(st)));
  if (st != null) {
    await addSource(ws, sType: st);
  }
}

Future<Source?> addSource(Workspace ws, {String? sType}) async => await editSource(ws, sType: sType);

Future<Source?> editSource(Workspace ws, {Source? src, String? sType}) async {
  final s = await editSourceDialog(ws, src, sType);
  if (s != null) {
    await ws.updateSourceInList(s);
    if (!s.deleted) {
      s.checkConnection();
    }
  }
  return s;
}

Future<Source?> editSourceDialog(Workspace ws, Source? src, String? sType) async => await showMTDialog<Source?>(SourceEditView(ws, src, sType));

class SourceEditView extends StatefulWidget {
  const SourceEditView(this.ws, this.src, this.sType);
  final Workspace ws;
  final Source? src;
  final String? sType;

  @override
  _SourceEditViewState createState() => _SourceEditViewState();
}

class _SourceEditViewState extends State<SourceEditView> {
  late final SourceEditController controller;

  bool get isNew => controller.source == null;
  bool get canSave => controller.validated;
  String get sourceCode => controller.selectedType != null ? controller.selectedType!.toLowerCase() : '';
  String get sourceEditHelperAddress => '$docsPath/import/$sourceCode';

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

  Widget textFieldForCode(String code, {bool first = false}) {
    final fd = controller.fData(code);
    return MTTextField(
      controller: controller.teControllers[code],
      label: fd.label,
      error: fd.errorText,
      obscureText: code == 'password',
      maxLines: 1,
      capitalization: TextCapitalization.none,
      margin: tfPadding.copyWith(top: first ? P_2 : tfPadding.top),
    );
  }

  Widget get _form => ListView(
        shrinkWrap: true,
        children: [
          textFieldForCode('url', first: true),
          if (controller.showUsername) textFieldForCode('username'),
          textFieldForCode('apiKey'),
          MTButton(
            titleText: loc.source_help_edit_action,
            trailing: const LinkOutIcon(size: P * 1.2),
            margin: tfPadding.copyWith(top: P_2),
            onTap: () => launchUrlString(sourceEditHelperAddress),
          ),
          textFieldForCode('description'),
          const SizedBox(height: P),
          MTButton.main(
            titleText: loc.save_action_title,
            onTap: canSave ? controller.save : null,
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
                if (isNew) MediumText(loc.source_title_new, padding: const EdgeInsets.only(right: P_2)),
                iconTitleForSourceType(controller.selectedType!),
              ]),
              if (mainController.workspaces.length > 1) controller.ws.subtitleRow
            ],
          ),
          trailing: controller.canEdit
              ? MTButton.icon(
                  const DeleteIcon(),
                  () => controller.delete(context),
                  margin: const EdgeInsets.only(right: P),
                )
              : null,
        ),
        body: _form,
      ),
    );
  }
}
