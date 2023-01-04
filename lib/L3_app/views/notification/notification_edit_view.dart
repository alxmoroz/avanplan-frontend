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
import 'notification_controller.dart';

Future<Source?> showNotificationDialog(BuildContext context) async {
  return await showModalBottomSheet<Source?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(NotificationView()),
  );
}

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  NotificationController get controller => notificationController;
  MTNotification get nf => controller.selectedNotification!;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Widget body() {
    final padding = MediaQuery.of(context).padding;
    return ListView(
      padding: padding.add(const EdgeInsets.all(P).copyWith(top: 0, bottom: padding.bottom > 0 ? 0 : P)),
      children: [
        // if (msg.event.task?.isProject == false) ...[
        //   const SizedBox(height: P_2),
        //   LightText(msg.event.projectTitle),
        // ],
        // const SizedBox(height: P_2),

        H3(nf.title),
        const SizedBox(height: P),
        H4(nf.description, color: greyColor, maxLines: 1000),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          middle: LightText('${loc.message_title}  ${nf.scheduledDate.strShortWTime}'),
          bgColor: backgroundColor,
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: body(),
        ),
      ),
    );
  }
}
