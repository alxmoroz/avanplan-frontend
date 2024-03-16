// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/calendar_event.dart';
import '../../extra/services.dart';

part 'calendar_controller.g.dart';

class CalendarController extends _CalendarControllerBase with _$CalendarController {}

abstract class _CalendarControllerBase with Store {
  @observable
  Iterable<String> googleAccounts = [];

  @observable
  Iterable<CalendarEvent> events = [];

  @observable
  bool loading = false;

  @action
  Future authenticateGoogleAccount() async {
    loading = true;
    googleAccounts = await calendarUC.authenticateGoogleAccount();
    loading = false;
  }

  @action
  Future getData() async {
    // список подключенных календарей (учёток гугла)
    googleAccounts = await calendarUC.getGoogleAccounts();

    // TODO: список событий из подключенных календарей
    events = [];
  }

  @action
  void clearData() {
    events = [];
    googleAccounts = [];
  }
}
