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
import '../../components/splash.dart';
import '../../components/text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'tracker_controller.dart';

Future<RemoteTracker?> showEditTrackerDialog(BuildContext context) async {
  return await showModalBottomSheet<RemoteTracker?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (context) => MTBottomSheet(TrackerEditView()),
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
  Future<void>? _fetchTypes;

  @override
  void initState() {
    _controller.initState(tfaList: [
      TFAnnotation('title', label: loc.common_title, text: _tracker?.title ?? ''),
      TFAnnotation('url', label: loc.tracker_url_placeholder, text: _tracker?.url ?? ''),
      TFAnnotation('loginKey', label: loc.auth_user_placeholder, text: _tracker?.loginKey ?? ''),
      TFAnnotation('password', label: loc.auth_password_placeholder),
    ]);

    _fetchTypes = _controller.fetchTypes();

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
              if (_controller.types.isNotEmpty)
                MTDropdown<RemoteTrackerType>(
                  width: mq.size.width - onePadding * 2,
                  onChanged: (type) => _controller.selectType(type),
                  value: _controller.selectedType,
                  items: _controller.types,
                  label: loc.tracker_type_placeholder,
                ),
              ...['title', 'url', 'loginKey', 'password'].map((code) => textFieldForCode(code)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchTypes,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done
          ? Observer(
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
                  middle: H3(_tracker == null ? loc.task_title_new : '', align: TextAlign.center),
                  trailing: Button(
                    loc.btn_save_title,
                    _controller.validated ? () => _controller.save(context) : null,
                    titleColor: _controller.validated ? mainColor : borderColor,
                    padding: EdgeInsets.only(right: onePadding),
                  ),
                ),
                body: form(),
              ),
            )
          : const SplashScreen(),
    );
  }
}
