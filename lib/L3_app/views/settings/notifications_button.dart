// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../navigation/router.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

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
            maxLines: 1,
          ),
        if (!kIsWeb) const ChevronIcon(),
      ]),
      bottomDivider: false,
      onTap: () {
        Navigator.of(context).pop();
        router.goNotifications();
      },
    );
  }
}
