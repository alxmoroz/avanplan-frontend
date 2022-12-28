// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/message.dart';
import '../../extra/services.dart';

part 'messages_controller.g.dart';

class MessagesController extends _MessagesControllerBase with _$MessagesController {}

abstract class _MessagesControllerBase with Store {
  @observable
  ObservableList<Message> messages = ObservableList();

  @action
  Future fetchData() async {
    messages = ObservableList.of((await myUC.getMessages()).sorted((m1, m2) => m1.event.createdOn.compareTo(m2.event.createdOn)));
  }

  @action
  void clearData() {
    messages.clear();
  }
}
