// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/remote_tracker.dart';
import '../../components/bottom_sheet.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/dropdown.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import 'tracker_controller.dart';

Future<RemoteTracker?> showEditTrackerDialog(BuildContext context) async {
  return await showModalBottomSheet<RemoteTracker?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => MTBottomSheet(TrackerEditView(), context),
  );
}

class TrackerEditView extends StatefulWidget {
  static String get routeName => 'tracker_edit';

  @override
  _TrackerEditViewState createState() => _TrackerEditViewState();
}

class _TrackerEditViewState extends State<TrackerEditView> {
  TrackerController get _controller => trackerController;
  RemoteTracker? get _tracker => _controller.selectedTracker;
  bool get _isNew => _tracker == null;
  bool get _canSave => _controller.validated;

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('url', label: loc.tracker_url_placeholder, text: _tracker?.url ?? ''),
      TFAnnotation('loginKey', label: loc.auth_user_placeholder, text: _tracker?.loginKey ?? ''),
      TFAnnotation('password', label: loc.auth_password_placeholder, needValidate: false),
      TFAnnotation('description', label: loc.common_description, text: _tracker?.description ?? '', needValidate: false),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) => MTTextField(
        controller: _controller.controllers[code],
        label: _controller.tfAnnoForCode(code).label,
        error: _controller.tfAnnoForCode(code).errorText,
        obscureText: code == 'password',
        maxLines: 1,
        capitalization: TextCapitalization.none,
      );

  Widget form() {
    final mq = MediaQuery.of(context);
    return Container(
      constraints: BoxConstraints(maxHeight: (mq.size.height - mq.viewInsets.bottom - mq.viewPadding.bottom) * 0.82),
      child: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_isNew) ..._controller.wsDropdown(context),
              if (_controller.rtTypes.isNotEmpty)
                MTDropdown<RemoteTrackerType>(
                  width: mq.size.width - onePadding * 2,
                  onChanged: (type) => _controller.selectType(type),
                  value: _controller.selectedType,
                  items: _controller.rtTypes,
                  label: loc.tracker_type_placeholder,
                ),
              ...['url', 'loginKey', 'password', 'description'].map((code) => textFieldForCode(code)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        bgColor: darkBackgroundColor,
        navBar: navBar(
          context,
          leading: _controller.canEdit
              ? Button.icon(
                  deleteIcon(context),
                  () => _controller.delete(context),
                  padding: EdgeInsets.only(left: onePadding),
                )
              : Container(),
          title: _isNew ? loc.tracker_title_new : '',
          trailing: Button(
            loc.btn_save_title,
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
