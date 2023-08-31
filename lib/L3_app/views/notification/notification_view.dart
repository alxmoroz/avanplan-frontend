// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/date.dart';

Future showNotificationDialog(BuildContext context) async => await showMTDialog<void>(NotificationView());

class NotificationView extends StatelessWidget {
  MTNotification get nf => notificationController.selectedNotification!;

  Widget get _body {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: ListView(
          shrinkWrap: true,
          children: [
            H3(nf.title, maxLines: 5),
            const SizedBox(height: P2),
            NormalText(nf.description, maxLines: 100),
            const SizedBox(height: P3),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: '${loc.notification_title}  ${nf.scheduledDate.strShortWTime}'),
      body: _body,
    );
  }
}
