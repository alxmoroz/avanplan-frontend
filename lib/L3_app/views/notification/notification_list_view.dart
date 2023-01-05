// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import 'notification_controller.dart';

class NotificationListView extends StatelessWidget {
  static String get routeName => 'notifications';

  NotificationController get _controller => notificationController;

  Widget _itemBuilder(BuildContext context, int index) {
    if (index < _controller.notifications.length) {
      final n = _controller.notifications[index];
      final date = n.scheduledDate.strShortWTime;
      final title = n.title;
      return MTListTile(
        middle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmallText(date),
            // if (m.event.task?.isProject == false) SmallText(m.event.projectTitle, color: greyColor),
            n.isRead ? NormalText(title) : MediumText(title),
          ],
        ),
        // subtitle: description.isNotEmpty && !m.isRead ? LightText(description, maxLines: 2) : null,
        trailing: const ChevronIcon(),
        onTap: () => _controller.showNotification(context, n: n),
      );
    } else {
      return SmallText(
        loc.notification_list_hint_title,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P, vertical: P2),
        color: greyColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTPage(
          navBar: navBar(context, title: loc.notification_list_title),
          body: SafeArea(
            top: false,
            bottom: false,
            child: _controller.notifications.isEmpty
                ? Center(child: H4(loc.notification_list_empty_title, align: TextAlign.center, color: lightGreyColor))
                : ListView.builder(
                    itemBuilder: (_, int index) => _itemBuilder(context, index),
                    itemCount: _controller.notifications.length + 1,
                  ),
          ),
        ),
      );
}
