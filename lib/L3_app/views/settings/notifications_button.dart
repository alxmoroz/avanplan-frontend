// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../navigation/router.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/services.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      color: b3Color,
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
      onTap: () {
        Navigator.of(context).pop();
        router.goNotifications();
      },
    );
  }
}
