// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/calendar.dart';
import '../../L1_domain/entities/calendar_source.dart';
import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/repositories/abs_calendar_repo.dart';
import '../mappers/calendar.dart';
import '../mappers/calendar_event.dart';
import '../mappers/calendar_source.dart';
import '../services/api.dart';

class CalendarRepo extends AbstractCalendarRepo {
  o_api.MyCalendarApi get _myCalendarApi => openAPI.getMyCalendarApi();

  GoogleSignIn get _gSI => GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/calendar.calendarlist.readonly',
          'https://www.googleapis.com/auth/calendar.events',
          'https://www.googleapis.com/auth/calendar.events.readonly',
        ],
      );

  @override
  Future<Iterable<CalendarSource>> getSources() async => (await _myCalendarApi.myCalendarSources()).data?.map((cs) => cs.source) ?? [];

  @override
  Future<CalendarsEvents> getCalendarsEvents() async {
    final data = (await _myCalendarApi.myCalendarsEvents()).data;
    return CalendarsEvents(
      data?.calendars.map((c) => c.calendar) ?? [],
      data?.events.map((ce) => ce.event) ?? [],
    );
  }

  Future<CalendarSource?> _updateSource(String accessToken, String email, String type) async {
    final response = await _myCalendarApi.myCalendarSourcesUpsert(
      bodyMyCalendarSourcesUpsert: (o_api.BodyMyCalendarSourcesUpsertBuilder()
            ..accessToken = accessToken
            ..email = email
            ..sourceType = type)
          .build(),
    );
    return response.data?.source;
  }

  Future<CalendarSource?> _updateGoogleSource() async {
    GoogleSignInAccount? account;
    GoogleSignInAuthentication? auth;
    try {
      account = await _gSI.signIn();
      auth = await account?.authentication;
    } on PlatformException catch (e) {
      if (e.code != 'popup_closed_by_user') {
        throw MTOAuthError('google', detail: e.code);
      }
    } catch (e) {
      throw MTOAuthError('google', detail: e.toString());
    }

    if (account != null && auth != null) {
      final accessToken = auth.accessToken;
      final email = account.email;

      if (accessToken != null) {
        return await _updateSource(accessToken, email, CalendarSourceType.GOOGLE.name);
      }
    }
    return null;
  }

  @override
  Future<CalendarSource?> updateSource(CalendarSourceType type) async {
    if (type == CalendarSourceType.GOOGLE) {
      return await _updateGoogleSource();
    }
    return null;
  }
}
