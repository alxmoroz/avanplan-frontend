// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';
import 'package:test/test.dart';

/// tests for MyCalendarApi
void main() {
  final instance = Openapi().getMyCalendarApi();

  group(MyCalendarApi, () {
    // Events
    //
    //Future<BuiltList<CalendarEvent>> myCalendarEvents() async
    test('test myCalendarEvents', () async {
      // TODO
    });

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
  });
}
