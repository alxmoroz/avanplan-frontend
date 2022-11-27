// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/source.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';
import '../../presenters/source_presenter.dart';
import 'source_controller.dart';

Future<Source?> editSourceDialog(BuildContext context) async {
  return await showModalBottomSheet<Source?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(SourceEditView()),
  );
}

class SourceEditView extends StatefulWidget {
  @override
  _SourceEditViewState createState() => _SourceEditViewState();
}

class _SourceEditViewState extends State<SourceEditView> {
  SourceController get _controller => sourceController;
  Source? get _source => _controller.selectedSource;
  bool get _isNew => _source == null;
  bool get _canSave => _controller.validated;

  String get _sourceCode => _controller.selectedType != null ? _controller.selectedType!.title.toLowerCase() : '';
  bool get _showUsername => _controller.selectedType?.title == 'Jira';

  String get _sourceEditHelperAddress => '$docsUrlPath/import/$_sourceCode';

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('url', label: loc.source_url_placeholder, text: _source?.url ?? ''),
      TFAnnotation('username', label: loc.auth_user_placeholder, text: _source?.username ?? '', needValidate: _showUsername),
      TFAnnotation('apiKey', label: loc.source_api_key_placeholder, text: _source?.apiKey ?? ''),
      // TFAnnotation('password', label: loc.auth_password_placeholder, needValidate: false),
      TFAnnotation('description', label: loc.description, text: _source?.description ?? '', needValidate: false),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.selectType(null);
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) {
    final tfa = _controller.tfAnnoForCode(code);

    String? helper = tfa.helper;
    if (code == 'apiKey' && helper == null) {
      helper = _controller.selectedType != null ? Intl.message('source_api_key_helper_' + _sourceCode) : null;
    }

    String? error;
    if (tfa.errorText != null) {
      error = tfa.errorText! + (helper != null ? '\n$helper' : '');
    }

    return MTTextField(
      controller: _controller.teControllers[code],
      label: tfa.label,
      error: error,
      helper: helper,
      obscureText: code == 'password',
      maxLines: 1,
      capitalization: TextCapitalization.none,
    );
  }

  Widget form() {
    return Scrollbar(
      child: ListView(
        children: [
          if (_isNew) _controller.wsDropdown(context),
          for (final code in [
            'url',
            if (_showUsername) 'username',
            'apiKey',
            // 'password',
            'description',
          ])
            textFieldForCode(code),
          MTButton(
            titleText: loc.source_help_edit_action,
            trailing: const LinkOutIcon(size: P * 1.3),
            margin: tfPadding.copyWith(top: P2),
            onTap: () => launchUrlString(_sourceEditHelperAddress),
          ),
          MTButton.outlined(
            titleText: loc.save_action_title,
            margin: tfPadding.copyWith(top: P2),
            onTap: _canSave ? () => _controller.save(context) : null,
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
              if (_isNew) MediumText(loc.source_title_new, padding: const EdgeInsets.only(right: P_2)),
              _controller.selectedType!.iconTitle,
            ],
          ),
          trailing: _controller.canEdit
              ? MTButton.icon(
                  const DeleteIcon(),
                  () => _controller.delete(context),
                  margin: const EdgeInsets.only(right: P),
                )
              : null,
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form()),
      ),
    );
  }
}
