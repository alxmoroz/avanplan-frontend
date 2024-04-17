// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../../L1_domain/entities_extensions/notification.dart';
import '../../../L2_data/services/platform.dart';
import '../../../main.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
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
    await notificationDialog();

    if (!n.isRead) {
      n.isRead = true;
      await myUC.markReadNotifications([n.id!]);
      // TODO: ещё один запрос ведь не обязателен тут! можно дернуть notifications = [...notifications]
      // TODO: либо получить новый набор уведомлений с запроса выше
      await reload();
    }
  }

  @observable
  bool pushAuthorized = false;

  Uri? _uri(RemoteMessage msg) {
    final data = msg.data;
    final String uriStr = data['uri'] ?? '';
    return uriStr.isNotEmpty ? Uri.parse(uriStr) : null;
  }

  Future _tryNavigate(RemoteMessage msg) async {
    final uri = _uri(msg);
    if (uri != null) {
      popTop();
      String rName = '';
      for (var ps in uri.pathSegments) {
        rName += '/$ps';
        // print(routeName);
        try {
          Navigator.of(rootKey.currentContext!).pushNamed(rName);
        } catch (_) {}
      }
    }
  }

  @action
  Future initPush() async {
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
      token = await FirebaseMessaging.instance.getToken();
    }
    final hasToken = token?.isNotEmpty == true;
    pushAuthorized = hasToken && authStatus == AuthorizationStatus.authorized;

    // Обновление токена на бэке
    if (hasToken) {
      await myUC.updatePushToken(token!, pushAuthorized);
    }

    // Обработка входящих push-уведомлений
    // onLaunch
    final msg = await FirebaseMessaging.instance.getInitialMessage();
    if (msg != null) {
      _tryNavigate(msg);
    }
    // onResume
    FirebaseMessaging.onMessageOpenedApp.listen(_tryNavigate);
  }
}
