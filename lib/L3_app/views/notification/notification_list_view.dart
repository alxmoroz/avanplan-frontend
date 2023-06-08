// Copyright (c) 2022. Alexandr Moroz

import 'package:app_settings/app_settings.dart' as sys_settings;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_adaptive.dart';
import '../../components/mt_alert_dialog.dart';
import '../../components/mt_button.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import 'notification_controller.dart';

class NotificationListView extends StatelessWidget {
  static String get routeName => '/notifications';

  NotificationController get _controller => notificationController;

  Widget _itemBuilder(BuildContext context, int index) {
    if (index < _controller.notifications.length) {
      final n = _controller.notifications[index];
      final date = n.scheduledDate.strShortWTime;
      final title = n.title;
      return MTListTile(
        middle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmallText(date),
            // if (m.event.task?.isProject == false) SmallText(m.event.projectTitle, color: greyColor),
            n.isRead ? NormalText(title) : MediumText(title),
          ],
        ),
        // subtitle: description.isNotEmpty && !m.isRead ? LightText(description, maxLines: 2) : null,
        trailing: const ChevronIcon(),
        onTap: () => _controller.showNotification(context, n: n),
      );
    } else {
      return SmallText(
        loc.notification_list_hint_title,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P, vertical: P2),
        color: greyColor,
      );
    }
  }

  Future _showGotoSystemSettingsDialog() async {
    final gotoSettings = await showMTAlertDialog(
      rootKey.currentContext!,
      title: loc.notification_push_ios_denied_dialog_title,
      description: loc.notification_push_ios_denied_dialog_description,
      actions: [
        MTADialogAction(title: loc.cancel, result: false),
        MTADialogAction(title: loc.app_settings_action_title, result: true, type: MTActionType.isDefault),
      ],
      simple: true,
    );
    if (gotoSettings == true) {
      await sys_settings.AppSettings.openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTPage(
          navBar: navBar(context, title: loc.notification_list_title),
          body: SafeArea(
            top: false,
            bottom: false,
            child: _controller.notifications.isEmpty
                ? Center(child: H4(loc.notification_list_empty_title, align: TextAlign.center, color: lightGreyColor))
                : MTAdaptive(
                    child: ListView.builder(
                      itemBuilder: (_, int index) => _itemBuilder(context, index),
                      itemCount: _controller.notifications.length + 1,
                    ),
                  ),
          ),
          bottomBar: _controller.pushDenied
              ? MTButton(
                  leading: const PrivacyIcon(color: mainColor, size: P2),
                  middle: SmallText(
                    loc.notification_push_ios_denied_btn_title,
                    align: TextAlign.center,
                  ),
                  onTap: _showGotoSystemSettingsDialog,
                )
              : null,
        ),
      );
}
