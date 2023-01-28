// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/notification.dart';

extension NotificationMapper on api.Notification {
  MTNotification get notification => MTNotification(
        id: id,
        title: title ?? '',
        description: description ?? '',
        scheduledDate: scheduledDate?.toLocal() ?? DateTime.now(),
        isRead: isRead,
        url: url,
        messageId: messageId,
      );
}
