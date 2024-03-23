// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/calendar.dart';
import '../../../L1_domain/entities/calendar_event.dart';
import '../../../L1_domain/entities/calendar_source.dart';
import '../../extra/services.dart';

part 'calendar_controller.g.dart';

class CalendarController extends _CalendarControllerBase with _$CalendarController {}

abstract class _CalendarControllerBase with Store {
  @observable
  ObservableList<CalendarSource> _sources = ObservableList();
  @computed
  List<CalendarSource> get sources => _sources.sortedBy<String>((s) => s.email);

  @observable
  ObservableList<Calendar> _calendars = ObservableList();
  @computed
  List<Calendar> get calendars => _calendars.sorted((c1, c2) => c1.compareTo(c2));

  @observable
  ObservableList<CalendarEvent> events = ObservableList();

  @observable
  bool loading = false;

  @action
  void _setSource(CalendarSource es) {
    final index = _sources.indexWhere((s) => s.id == es.id);
    if (index > -1) {
      _sources[index] = es;
    } else {
      _sources.add(es);
    }
  }

  @action
  Future authenticateGoogleCalendar() async {
    loading = true;
    final es = await calendarUC.updateSource(CalendarSourceType.GOOGLE);
    if (es != null) {
      _setSource(es);
    }
    loading = false;
  }

  @action
  Future getData() async {
    // список подключенных календарей (учёток гугла, эпла и т.п.)
    _sources = ObservableList.of(await calendarUC.getSources());

    // календари и события
    final data = await calendarUC.getCalendarsEvents();
    _calendars = ObservableList.of(data.calendars);
    events = ObservableList.of(data.events);
  }

  @action
  void clearData() {
    events.clear();
    _sources.clear();
  }
}
