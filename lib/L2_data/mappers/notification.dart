// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/notification.dart';
import '../../L1_domain/utils/dates.dart';

extension NotificationMapper on api.Notification {
  MTNotification get notification => MTNotification(
        id: id,
        title: title ?? '',
        description: description ?? '',
        scheduledDate: scheduledDate?.toLocal() ?? now,
        isRead: isRead,
        url: url,
        messageId: messageId,
      );
}
