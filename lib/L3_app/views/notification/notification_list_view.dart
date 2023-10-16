// Copyright (c) 2022. Alexandr Moroz

import 'package:app_settings/app_settings.dart' as sys_settings;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/alert_dialog.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/date.dart';
import 'notification_controller.dart';

class NotificationListView extends StatelessWidget {
  static String get routeName => '/notifications';
  static String get title => loc.notification_list_title;

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
            n.isRead ? BaseText(title) : BaseText.medium(title),
          ],
        ),
        // subtitle: description.isNotEmpty && !m.isRead ? LightText(description, maxLines: 2) : null,
        trailing: const ChevronIcon(),
        bottomDivider: index < _controller.notifications.length - 1,
        onTap: () => _controller.showNotification(context, n: n),
      );
    } else {
      return SmallText(
        loc.notification_list_hint_title,
        align: TextAlign.center,
        padding: const EdgeInsets.all(P3),
      );
    }
  }

  Future _showGotoSystemSettingsDialog() async {
    final gotoSettings = await showMTAlertDialog(
      loc.notification_push_ios_denied_dialog_title,
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
          appBar: MTAppBar(context, title: title),
          body: SafeArea(
            top: false,
            bottom: false,
            child: _controller.notifications.isEmpty
                ? Center(child: H3(loc.notification_list_empty_title, align: TextAlign.center, color: f2Color))
                : MTShadowed(
                    bottomShadow: !_controller.pushAuthorized,
                    child: MTAdaptive(
                      child: ListView.builder(
                        itemBuilder: (_, index) => _itemBuilder(context, index),
                        itemCount: _controller.notifications.length + 1,
                      ),
                    ),
                  ),
          ),
          bottomBar: !_controller.pushAuthorized
              ? MTButton(
                  leading: const PrivacyIcon(),
                  middle: SmallText(
                    loc.notification_push_ios_denied_btn_title,
                    align: TextAlign.center,
                    height: 1,
                  ),
                  trailing: const LinkOutIcon(),
                  onTap: _showGotoSystemSettingsDialog,
                )
              : null,
        ),
      );
}
