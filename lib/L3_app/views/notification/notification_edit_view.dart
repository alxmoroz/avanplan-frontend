// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/notification.dart';
import '../../../L1_domain/entities/source.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';

Future<Source?> showNotificationDialog(BuildContext context) async {
  return await showModalBottomSheet<Source?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(NotificationView()),
  );
}

class NotificationView extends StatelessWidget {
  MTNotification get nf => notificationController.selectedNotification!;

  Widget get _body {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: ListView(
          children: [
            H3(nf.title),
            const SizedBox(height: P),
            H4(nf.description, color: greyColor, maxLines: 500),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          middle: LightText('${loc.notification_title}  ${nf.scheduledDate.strShortWTime}'),
          bgColor: backgroundColor,
        ),
        body: SafeArea(
          bottom: false,
          child: _body,
        ),
      ),
    );
  }
}
