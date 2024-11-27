// Copyright (c) 2024. Alexandr Moroz

import 'package:app_settings/app_settings.dart' as sys_settings;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities_extensions/notification.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/alert_dialog.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../navigation/route.dart';
import '../../presenters/date.dart';
import 'notification_controller.dart';

class NotificationsRoute extends MTRoute {
  static const staticBaseName = 'my_notifications';

  NotificationsRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, __) => const _NotificationsDialog(),
        );

  @override
  bool isDialog(BuildContext context) => true;

  @override
  double get dialogMaxWidth => SCR_M_WIDTH;

  @override
  String title(GoRouterState state) => loc.notification_list_title;
}

class _NotificationsDialog extends StatelessWidget {
  const _NotificationsDialog();

  NotificationController get _controller => notificationController;

  Widget _itemBuilder(BuildContext context, int index) {
    if (index < _controller.notifications.length) {
      final n = _controller.notifications[index];
      final date = n.scheduledDate.strMedium;
      final time = n.scheduledDate.strTime;
      final title = n.title;
      return MTListTile(
        middle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SmallText(title, weight: FontWeight.w500, maxLines: 1),
                      if (n.description.isNotEmpty)
                        BaseText(
                          n.description,
                          maxLines: 3,
                          weight: !n.hasDetails || n.isRead ? null : FontWeight.w500,
                          padding: const EdgeInsets.only(top: P),
                        ),
                    ],
                  ),
                ),
                if (!kIsWeb && n.hasDetails) const ChevronIcon(),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SmallText(
                '$date $time',
                color: f3Color,
                maxLines: 1,
                padding: const EdgeInsets.only(top: P),
              ),
            ),
          ],
        ),
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
      imageName: ImageName.notifications.name,
      title: loc.notification_push_ios_denied_dialog_title,
      description: loc.notification_push_ios_denied_dialog_description,
      actions: [
        MTDialogAction(title: loc.action_goto_app_settings_title, type: MTButtonType.main),
        MTDialogAction(title: loc.action_no_i_dont_allow, type: MTButtonType.text),
      ],
    );
    if (gotoSettings == true) {
      await sys_settings.AppSettings.openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTTopBar(pageTitle: loc.notification_list_title),
        body: _controller.notifications.isEmpty
            ? Center(child: H3(loc.notification_list_empty_title, align: TextAlign.center, color: f2Color))
            : ListView(
                shrinkWrap: true,
                children: [
                  if (!isWeb && !_controller.pushAuthorized)
                    MTListTile(
                      margin: const EdgeInsets.only(bottom: P3),
                      leading: const BellIcon(size: P5),
                      middle: SmallText(loc.notification_push_ios_denied_btn_title, maxLines: 2),
                      trailing: const ChevronIcon(),
                      bottomDivider: false,
                      onTap: _showGotoSystemSettingsDialog,
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) => _itemBuilder(context, index),
                    itemCount: _controller.notifications.length + 1,
                  ),
                ],
              ),
      );
    });
  }
}
