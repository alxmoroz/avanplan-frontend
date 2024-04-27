// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  void _toNotifications() {
    goRouter.pop();
    goRouter.goNotifications();
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
      onTap: _toNotifications,
    );
  }
}
