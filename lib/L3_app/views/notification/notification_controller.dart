// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../../L1_domain/entities_extensions/notification.dart';
import '../../../L2_data/services/platform.dart';
import '../../navigation/router.dart';
import '../app/services.dart';
import 'notification_dialog.dart';

part 'notification_controller.g.dart';

class NotificationController extends _NotificationControllerBase with _$NotificationController {}

abstract class _NotificationControllerBase with Store {
  @observable
  List<MTNotification> notifications = [];

  @observable
  int? selectedNotificationId;

  @computed
  int get unreadCount => notifications.where((n) => n.hasDetails && !n.isRead).length;

  @computed
  bool get hasUnread => unreadCount > 0;

  @action
  void _selectNotification(MTNotification? n) => selectedNotificationId = n?.id;

  @computed
  MTNotification? get selectedNotification => notifications.firstWhereOrNull((m) => m.id == selectedNotificationId);

  @action
  Future reload() async => notifications = (await myUC.getNotifications()).sorted((n1, n2) => n2.scheduledDate.compareTo(n1.scheduledDate));

  @action
  void clear() => notifications = [];

  Future showNotification(BuildContext context, {required MTNotification n}) async {
    _selectNotification(n);
    notificationDialog();

    if (!n.isRead) {
      n.isRead = true;
      await myUC.markReadNotifications([n.id!]);
      notifications = [...notifications];
    }
  }

  @observable
  bool pushAuthorized = false;

  Future tryNavigate(RemoteMessage msg) async {
    final data = msg.data;
    final String uriStr = data['uri'] ?? '';
    if (Uri.tryParse(uriStr) != null) {
      router.go(uriStr);
    }
  }

  @action
  Future _initPush() async {
    // Запрос разрешения на отправку уведомлений
    final authStatus = (await FirebaseMessaging.instance.requestPermission()).authorizationStatus;

    // Получение токена
    String? token;
    if (isWeb) {
      // TODO: на сафари вообще виснет приложение пока что
      // token = await FirebaseMessaging.instance.getToken(
      //   vapidKey: isWeb ? 'BCOA2mDb6-CkpUHqBhSYe5Ave8GES9JBE--Ux2LpgiQ5GyZBSaLZpHjqSH9-LDnC-K7QUtoyXM_BnaetF6pw5Xc' : null,
      // );
    } else {
      try {
        token = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    final hasToken = token?.isNotEmpty == true;
    pushAuthorized = hasToken && authStatus == AuthorizationStatus.authorized;

    // Обновление токена на бэке
    if (hasToken) {
      await myUC.updatePushToken(token!, pushAuthorized);
    }
  }

  // Обработка входящих push-уведомлений
  Future _listenMessages() async {
    // onLaunch
    final msg = await FirebaseMessaging.instance.getInitialMessage();
    if (msg != null) tryNavigate(msg);

    // onResume
    FirebaseMessaging.onMessageOpenedApp.listen((msg) => tryNavigate(msg));
  }

  Future setup() async {
    await _listenMessages();
    await _initPush();
  }
}
