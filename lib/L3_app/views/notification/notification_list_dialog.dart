// Copyright (c) 2024. Alexandr Moroz

import 'package:app_settings/app_settings.dart' as sys_settings;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities_extensions/notification.dart';
import '../../../L1_domain/utils/dates.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/date.dart';
import 'notification_controller.dart';

class NotificationsRouter extends MTRouter {
  @override
  String path({Object? args}) => '/settings/my_notifications';

  @override
  bool get isDialog => true;

  @override
  String get title => loc.notification_list_title;

  @override
  Widget get page => const _NotificationListDialog();
}

class _NotificationListDialog extends StatelessWidget {
  const _NotificationListDialog();

  NotificationController get _controller => notificationController;

  Widget _itemBuilder(BuildContext context, int index) {
    if (index < _controller.notifications.length) {
      final n = _controller.notifications[index];
      final date = n.scheduledDate.date.strMedium;
      final time = n.scheduledDate.strTime;
      final title = n.title;
      return MTListTile(
        middle: SmallText('$date $time', maxLines: 1),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BaseText(title, weight: !n.hasDetails || n.isRead ? null : FontWeight.w500, maxLines: 1),
            if (n.description.isNotEmpty) SmallText(n.description, maxLines: 5, padding: const EdgeInsets.only(top: P)),
          ],
        ),
        trailing: n.hasDetails ? const ChevronIcon() : null,
        bottomDivider: index < _controller.notifications.length - 1,
        onTap: n.hasDetails ? () => _controller.showNotification(context, n: n) : null,
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
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.notification_list_title),
        body: _controller.notifications.isEmpty
            ? Center(child: H3(loc.notification_list_empty_title, align: TextAlign.center, color: f2Color))
            : ListView(
                shrinkWrap: true,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) => _itemBuilder(context, index),
                    itemCount: _controller.notifications.length + 1,
                  ),
                  if (!isWeb && !_controller.pushAuthorized) ...[
                    MTButton(
                      margin: const EdgeInsets.all(P3).copyWith(bottom: 0),
                      leading: const PrivacyIcon(),
                      middle: SmallText(
                        loc.notification_push_ios_denied_btn_title,
                        align: TextAlign.center,
                        maxLines: 2,
                      ),
                      onTap: _showGotoSystemSettingsDialog,
                    ),
                    if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                  ],
                ],
              ),
      );
    });
  }
}
