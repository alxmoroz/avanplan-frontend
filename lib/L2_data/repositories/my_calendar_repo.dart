// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../L1_domain/entities/calendar.dart';
import '../../L1_domain/entities/calendar_source.dart';
import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/repositories/abs_my_calendar_repo.dart';
import '../mappers/calendar.dart';
import '../mappers/calendar_event.dart';
import '../mappers/calendar_source.dart';
import '../services/api.dart';
import 'auth_google_repo.dart';

class MyCalendarRepo extends AbstractMyCalendarRepo {
  o_api.MyCalendarApi get _myCalendarApi => avanplanApi.getMyCalendarApi();

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

  Future<CalendarSource?> _updateSource(String serverAuthCode, String email, String type) async {
    final response = await _myCalendarApi.myCalendarSourcesUpsert(
      bodyMyCalendarSourcesUpsert: (o_api.BodyMyCalendarSourcesUpsertBuilder()
            ..serverAuthCode = serverAuthCode
            ..email = email
            ..sourceType = type)
          .build(),
    );
    return response.data?.source;
  }

  static const _scopes = [
    'https://www.googleapis.com/auth/calendar.calendarlist.readonly',
    'https://www.googleapis.com/auth/calendar.events',
    'https://www.googleapis.com/auth/calendar.events.readonly',
  ];

  static const _error_message = 'google calendar scopes';

  Future<CalendarSource?> _updateGoogleSource() async {
    try {
      GoogleSignInAccount? googleUser;
      GoogleSignIn gsi = mainGSI;
      // если пользователь уже авторизован в гугле, то запрашиваем доп. права
      final wasAuth = await gsi.isSignedIn();
      if (wasAuth) {
        // TODO: тут возможно добавить логику хранения инфы про разрешения на нашем бэке
        // проверка на наличие текущих прав доступна только для веба
        await gsi.requestScopes(_scopes);
        googleUser = gsi.currentUser;
      }
      // если не авторизован, то доп. права запрашиваем вместе с авторизацией
      else {
        gsi = gSI(scopes: _scopes);
        googleUser = await gsi.signIn();
      }

      if (googleUser != null) {
        final serverAuthCode = googleUser.serverAuthCode;
        if (serverAuthCode != null) {
          // разлогиниваем из гугла, если не был залогинен в гугле (другой провайдер авторизации и т.п.)
          if (!wasAuth) {
            await gsi.signOut();
          }
          // источник календаря
          return await _updateSource(serverAuthCode, googleUser.email, CalendarSourceType.GOOGLE.name);
        }
      }
    } on PlatformException catch (e) {
      if (e.code != 'popup_closed_by_user') {
        throw MTOAuthError(_error_message, detail: e.code);
      }
    } catch (e) {
      throw MTOAuthError(_error_message, detail: '$e');
    }
    throw MTOAuthError(_error_message, detail: '???');
  }

  @override
  Future<CalendarSource?> updateSource(CalendarSourceType type) async {
    if (type == CalendarSourceType.GOOGLE) {
      return await _updateGoogleSource();
    }
    return null;
  }
}
