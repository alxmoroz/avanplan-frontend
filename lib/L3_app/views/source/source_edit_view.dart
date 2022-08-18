// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/source.dart';
import '../../components/close_dialog_button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_source_presenter.dart';
import 'source_controller.dart';

Future<Source?> showEditSourceDialog(BuildContext context) async {
  return await showModalBottomSheet<Source?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => MTBottomSheet(SourceEditView(), context),
  );
}

class SourceEditView extends StatefulWidget {
  static String get routeName => 'source_edit';

  @override
  _SourceEditViewState createState() => _SourceEditViewState();
}

class _SourceEditViewState extends State<SourceEditView> {
  SourceController get _controller => sourceController;
  Source? get _source => _controller.selectedSource;
  bool get _isNew => _source == null;
  bool get _canSave => _controller.validated;

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('url', label: loc.source_url_placeholder, text: _source?.url ?? ''),
      TFAnnotation('login', label: loc.auth_user_placeholder, text: _source?.login ?? ''),
      TFAnnotation('apiKey', label: loc.source_api_key_placeholder, text: _source?.apiKey ?? ''),
      // TFAnnotation('password', label: loc.auth_password_placeholder, needValidate: false),
      TFAnnotation('description', label: loc.common_description, text: _source?.description ?? '', needValidate: false),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) => MTTextField(
        controller: _controller.teControllers[code],
        label: _controller.tfAnnoForCode(code).label,
        error: _controller.tfAnnoForCode(code).errorText,
        obscureText: code == 'password',
        maxLines: 1,
        capitalization: TextCapitalization.none,
      );

  List<DropdownMenuItem<SourceType>> srcTypeDdItems(BuildContext context, Iterable<SourceType> sTypes) => sTypes
      .map((st) => DropdownMenuItem<SourceType>(
            value: st,
            child: Row(children: [
              sourceTypeIcon(context, st),
              SizedBox(width: onePadding / 2),
              NormalText('$st'),
            ]),
          ))
      .toList();

  Widget form() {
    return Scrollbar(
      child: ListView(
        children: [
          if (_isNew) _controller.wsDropdown(context),
          if (_controller.sTypes.isNotEmpty)
            MTDropdown<SourceType>(
              onChanged: (type) => _controller.selectType(type),
              value: _controller.selectedType,
              ddItems: srcTypeDdItems(context, _controller.sTypes),
              label: loc.source_type_placeholder,
            ),
          ...[
            'url',
            if (_controller.selectedType?.title == 'Jira') 'login',
            'apiKey',
            // 'password',
            'description',
          ].map((code) => textFieldForCode(code)),
          if (_controller.canEdit)
            MTButton(
              loc.common_delete_btn_title,
              () => _controller.delete(context),
              titleColor: dangerColor,
              padding: EdgeInsets.only(top: onePadding),
            ),
          SizedBox(height: onePadding * 2),
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
          leading: CloseDialogButton(),
          title: _isNew ? loc.source_title_new : '',
          trailing: MTButton(
            loc.common_save_btn_title,
            _canSave ? () => _controller.save(context) : null,
            titleColor: _canSave ? mainColor : borderColor,
            padding: EdgeInsets.only(right: onePadding),
          ),
        ),
        body: form(),
      ),
    );
  }
}
