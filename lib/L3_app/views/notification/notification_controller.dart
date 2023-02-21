// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_apns_only/flutter_apns_only.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../../L2_data/services/push_service.dart';
import '../../extra/services.dart';
import 'notification_edit_view.dart';

part 'notification_controller.g.dart';

class NotificationController extends _NotificationControllerBase with _$NotificationController {}

abstract class _NotificationControllerBase with Store {
  @observable
  List<MTNotification> notifications = [];

  @observable
  int? selectedNotificationId;

  @computed
  int get unreadCount => notifications.where((n) => !n.isRead).length;

  @computed
  bool get hasUnread => unreadCount > 0;

  @action
  void selectNotification(MTNotification? n) => selectedNotificationId = n?.id;

  @computed
  MTNotification? get selectedNotification => notifications.firstWhereOrNull((m) => m.id == selectedNotificationId);

  @action
  Future fetchData() async {
    notifications = (await myUC.getNotifications()).sorted((n1, n2) => n2.scheduledDate.compareTo(n1.scheduledDate));
  }

  @action
  void clearData() => notifications.clear();

  Future showNotification(BuildContext context, {required MTNotification n}) async {
    selectNotification(n);
    await showNotificationDialog(context);

    if (!n.isRead) {
      n.isRead = true;
      await myUC.markReadNotifications([n.id!]);
      await fetchData();
    }
  }

  Future initPush() async {
    final connector = await getApnsTokenConnector();
    final token = connector.token.value;
    final hasPermission = await connector.getAuthorizationStatus() == ApnsAuthorizationStatus.authorized;

    if (token != null) {
      await myUC.updatePushToken(token, hasPermission);
    }
  }
}
