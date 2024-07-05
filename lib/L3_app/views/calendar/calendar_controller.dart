// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/calendar.dart';
import '../../../L1_domain/entities/calendar_event.dart';
import '../../../L1_domain/entities/calendar_source.dart';
import '../../extra/services.dart';
import '../../views/_base/loadable.dart';

part 'calendar_controller.g.dart';

class CalendarController extends _CalendarControllerBase with _$CalendarController {
  CalendarController() {
    setLoaderScreenLoading();
  }
}

abstract class _CalendarControllerBase with Store, Loadable {
  @observable
  ObservableList<CalendarSource> _sources = ObservableList();
  @computed
  List<CalendarSource> get sources => _sources.sortedBy<String>((s) => s.email);

  @observable
  ObservableList<Calendar> _calendars = ObservableList();
  @computed
  List<Calendar> get calendars => _calendars.sorted((c1, c2) => c1.compareTo(c2));

  Calendar? calendarForId(int id) => _calendars.firstWhereOrNull((c) => c.id == id);

  @observable
  ObservableList<CalendarEvent> events = ObservableList();

  @action
  void _setSource(CalendarSource cs) {
    final index = _sources.indexWhere((s) => s.id == cs.id);
    if (index > -1) {
      _sources[index] = cs;
    } else {
      _sources.add(cs);
    }
  }

  @action
  Future authenticateGoogleCalendar() async {
    await load(() async {
      final cs = await myCalendarUC.updateSource(CalendarSourceType.GOOGLE);
      if (cs != null) {
        _setSource(cs);
      }
    });
  }

  @action
  Future reload() async {
    // список подключенных календарей (учёток гугла, эпла и т.п.)
    _sources = ObservableList.of(await myCalendarUC.getSources());

    // календари и события
    final data = await myCalendarUC.getCalendarsEvents();
    _calendars = ObservableList.of(data.calendars);
    events = ObservableList.of(data.events);

    stopLoading();
  }

  @action
  void clear() {
    events.clear();
    _sources.clear();
  }
}
