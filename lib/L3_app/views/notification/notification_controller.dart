// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_apns_only/flutter_apns_only.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../../L2_data/services/push_service.dart';
import '../../../main.dart';
import '../../extra/services.dart';
import 'notification_view.dart';

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
  void _selectNotification(MTNotification? n) => selectedNotificationId = n?.id;

  @computed
  MTNotification? get selectedNotification => notifications.firstWhereOrNull((m) => m.id == selectedNotificationId);

  @action
  Future getData() async => notifications = (await myUC.getNotifications()).sorted((n1, n2) => n2.scheduledDate.compareTo(n1.scheduledDate));

  @action
  void clearData() => notifications = [];

  Future showNotification(BuildContext context, {required MTNotification n}) async {
    _selectNotification(n);
    await notificationDialog(context);

    if (!n.isRead) {
      n.isRead = true;
      await myUC.markReadNotifications([n.id!]);
      // TODO: ещё один запрос ведь не обязателен тут! можно дернуть notifications = [...notifications]
      // TODO: либо получить новый набор уведомлений с запроса выше
      await getData();
    }
  }

  @observable
  bool pushAuthorized = false;

  Uri? _uri(ApnsRemoteMessage msg) {
    final Map? data = msg.payload['data'];
    final String uriStr = data?['uri'] ?? '';
    return uriStr.isNotEmpty ? Uri.parse(uriStr) : null;
  }

  Future _tryNavigate(ApnsRemoteMessage msg) async {
    final uri = _uri(msg);
    if (uri != null) {
      Navigator.of(rootKey.currentContext!).popUntil((r) => r.navigator?.canPop() != true);
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
    final connector = await getApnsTokenConnector(
      onLaunch: _tryNavigate,
      onMessage: (msg) async {
        // print('onMessage $msg');
      },
      onResume: _tryNavigate,
      onBackgroundMessage: (msg) async {
        // print('onBackgroundMessage $msg');
      },
    );

    final token = connector.token.value;
    final hasToken = token?.isNotEmpty == true;
    final authStatus = await connector.getAuthorizationStatus();
    pushAuthorized = hasToken && authStatus == ApnsAuthorizationStatus.authorized;
    // pushDenied = authStatus == ApnsAuthorizationStatus.denied;

    if (hasToken) {
      await myUC.updatePushToken(token!, pushAuthorized);
    }
  }
}
