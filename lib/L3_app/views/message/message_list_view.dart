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
import 'message_controller.dart';

class MessageListView extends StatelessWidget {
  static String get routeName => 'messages';

  MessageController get _controller => messageController;

  Widget _messageBuilder(BuildContext context, int index) {
    if (index < _controller.messages.length) {
      final m = _controller.messages[index];
      final date = m.event.createdOn.strShortWTime;
      final title = m.event.type.code;
      return MTListTile(
        middle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SmallText(date),
            // if (m.event.task?.isProject == false) SmallText(m.event.projectTitle, color: greyColor),
            m.isRead ? NormalText(title) : MediumText(title),
          ],
        ),
        // subtitle: description.isNotEmpty && !m.isRead ? LightText(description, maxLines: 2) : null,
        trailing: const ChevronIcon(),
        onTap: () => _controller.showMessage(context, msg: m),
      );
    } else {
      return SmallText(
        loc.message_list_hint_title,
        align: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: P, vertical: P2),
        color: greyColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTPage(
          navBar: navBar(context, title: loc.message_list_title),
          body: SafeArea(
            top: false,
            bottom: false,
            child: _controller.messages.isEmpty
                ? Center(child: H4(loc.message_list_empty_title, align: TextAlign.center, color: lightGreyColor))
                : ListView.builder(
                    itemBuilder: (_, int index) => _messageBuilder(context, index),
                    itemCount: _controller.messages.length + 1,
                  ),
          ),
        ),
      );
}
