// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/message.dart';
import '../../extra/services.dart';
import 'message_edit_view.dart';

part 'message_controller.g.dart';

class MessageController extends _MessagesControllerBase with _$MessageController {}

abstract class _MessagesControllerBase with Store {
  @observable
  List<Message> messages = [];

  @observable
  int? selectedMsgId;

  @computed
  int get unreadCount => messages.where((m) => !m.isRead).length;

  @computed
  bool get hasUnread => unreadCount > 0;

  @action
  void selectMessage(Message? _m) => selectedMsgId = _m?.id;

  @computed
  Message? get selectedMessage => messages.firstWhereOrNull((m) => m.id == selectedMsgId);

  @action
  Future fetchData() async {
    messages = (await myUC.getMessages()).sorted((m1, m2) => m2.event.createdOn.compareTo(m1.event.createdOn));
  }

  @action
  void clearData() => messages.clear();

  Future showMessage(BuildContext context, {required Message msg}) async {
    selectMessage(msg);
    await editMessageDialog(context);

    if (!msg.isRead) {
      msg.readDate = DateTime.now();
      await myUC.updateMessages([msg]);
      await fetchData();
    }
  }
}
