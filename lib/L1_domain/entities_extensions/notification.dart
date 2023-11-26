// Copyright (c) 2023. Alexandr Moroz

import '../entities/notification.dart';

extension NotificationExtension on MTNotification {
  bool get hasDetails => description.length > 240 || url?.isNotEmpty == true;
}
