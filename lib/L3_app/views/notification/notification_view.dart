// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../../L1_domain/utils/dates.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/date.dart';

Future notificationDialog(BuildContext context) async => await showMTDialog<void>(NotificationView());

class NotificationView extends StatelessWidget {
  MTNotification get nf => notificationController.selectedNotification!;

  Widget get _body {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: ListView(
          shrinkWrap: true,
          children: [
            BaseText(nf.description, maxLines: 100),
            const SizedBox(height: P),
            SmallText('${nf.scheduledDate.date.strMedium} ${nf.scheduledDate.strTime}', maxLines: 1, align: TextAlign.right),
            const SizedBox(height: P3),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: nf.title),
      body: _body,
    );
  }
}
