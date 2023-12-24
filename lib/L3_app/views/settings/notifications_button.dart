// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../notification/notification_list_dialog.dart';

class NotificationsButton extends StatelessWidget {
  void _toNotifications(BuildContext context) {
    Navigator.of(context).pop();
    MTRouter.navigate(NotificationsRouter, context);
  }

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: BellIcon(hasUnread: notificationController.hasUnread),
      titleText: loc.notification_list_title,
      trailing: Row(children: [
        if (notificationController.notifications.isNotEmpty)
          BaseText(
            '${notificationController.notifications.length}',
            padding: const EdgeInsets.only(right: P),
          ),
        const ChevronIcon(),
      ]),
      bottomDivider: false,
      onTap: () => _toNotifications(context),
    );
  }
}
