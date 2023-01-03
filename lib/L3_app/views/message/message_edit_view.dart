// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/message.dart';
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
import 'message_controller.dart';

Future<Source?> editMessageDialog(BuildContext context) async {
  return await showModalBottomSheet<Source?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(MessageEditView()),
  );
}

class MessageEditView extends StatefulWidget {
  @override
  _MessageEditViewState createState() => _MessageEditViewState();
}

class _MessageEditViewState extends State<MessageEditView> {
  MessageController get controller => messageController;
  EventMessage get msg => controller.selectedMessage!;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Widget form() {
    final padding = MediaQuery.of(context).padding;
    return ListView(
      padding: padding.add(const EdgeInsets.all(P).copyWith(top: 0, bottom: padding.bottom > 0 ? 0 : P)),
      children: [
        // if (msg.event.task?.isProject == false) ...[
        //   const SizedBox(height: P_2),
        //   LightText(msg.event.projectTitle),
        // ],
        // const SizedBox(height: P_2),
        // H3(msg.event.title),
        // const SizedBox(height: P),
        // H4(msg.event.localizedDescription, color: greyColor, maxLines: 1000),
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
          middle: LightText('${loc.message_title}  ${msg.event.createdOn.strShortWTime}'),
          bgColor: backgroundColor,
        ),
        body: SafeArea(top: false, bottom: false, child: form()),
      ),
    );
  }
}
