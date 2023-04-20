// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../../L2_data/repositories/communications_repo.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../usecases/source_ext.dart';
import '../../usecases/ws_ext_sources.dart';
import 'source_edit_controller.dart';

Future<Source?> addSource({String? sType}) async => await editSource(sType: sType);

Future<Source?> editSource({Source? src, String? sType}) async {
  final s = await editSourceDialog(src, sType);
  if (s != null) {
    await mainController.selectedWS!.updateSourceInList(s);
    if (!s.deleted) {
      s.checkConnection();
    }
  }
  return s;
}

Future<Source?> editSourceDialog(Source? src, String? sType) async {
  return await showModalBottomSheet<Source?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(SourceEditView(src, sType)),
  );
}

class SourceEditView extends StatefulWidget {
  const SourceEditView(this.src, this.sType);
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
    controller = SourceEditController(widget.src?.id, widget.sType);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) {
    final tfa = controller.tfAnnoForCode(code);

    String? helper = tfa.helper;
    if (code == 'apiKey' && helper == null) {
      helper = controller.selectedType != null ? Intl.message('source_api_key_helper_' + sourceCode) : null;
    }

    String? error;
    if (tfa.errorText != null) {
      error = tfa.errorText! + (helper != null ? '\n$helper' : '');
    }

    return MTTextField(
      controller: controller.teControllers[code],
      label: tfa.label,
      error: error,
      helper: helper,
      obscureText: code == 'password',
      maxLines: 1,
      capitalization: TextCapitalization.none,
    );
  }

  Widget form(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          for (final code in [
            'url',
            if (controller.showUsername) 'username',
            'apiKey',
            // 'password',
            'description',
          ])
            textFieldForCode(code),
          MTButton(
            titleText: loc.source_help_edit_action,
            trailing: const LinkOutIcon(size: P * 1.3),
            margin: tfPadding.copyWith(top: P2),
            onTap: () => launchUrlString(sourceEditHelperAddress),
          ),
          MTButton.outlined(
            titleText: loc.save_action_title,
            margin: tfPadding.copyWith(top: P2),
            onTap: canSave ? () => controller.save(context) : null,
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
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isNew) MediumText(loc.source_title_new, padding: const EdgeInsets.only(right: P_2)),
              iconTitleForSourceType(controller.selectedType!),
            ],
          ),
          trailing: controller.canEdit
              ? MTButton.icon(
                  const DeleteIcon(),
                  () => controller.delete(context),
                  margin: const EdgeInsets.only(right: P),
                )
              : null,
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form(context)),
      ),
    );
  }
}
