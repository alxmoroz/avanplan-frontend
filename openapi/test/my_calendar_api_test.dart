import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyCalendarApi
void main() {
  final instance = Openapi().getMyCalendarApi();

  group(MyCalendarApi, () {
    // Sources
    //
    //Future<BuiltList<CalendarSourceGet>> myCalendarSources() async
    test('test myCalendarSources', () async {
      // TODO
    });

    // Upsert
    //
    //Future<CalendarSourceGet> myCalendarSourcesUpsert(BodyMyCalendarSourcesUpsert bodyMyCalendarSourcesUpsert) async
    test('test myCalendarSourcesUpsert', () async {
      // TODO
    });

    // Calendars Events
    //
    //Future<CalendarsEvents> myCalendarsEvents() async
    test('test myCalendarsEvents', () async {
      // TODO
    });
  });
}
