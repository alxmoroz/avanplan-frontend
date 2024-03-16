// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/repositories/abs_calendar_repo.dart';
import '../services/api.dart';

class CalendarGoogleRepo extends AbstractCalendarGoogleRepo {
  MyCalendarApi get _myCalendarApi => openAPI.getMyCalendarApi();

  GoogleSignIn get _gSI => GoogleSignIn(
        scopes: [
          'https://www.googleapis.com/auth/calendar.calendarlist.readonly',
          'https://www.googleapis.com/auth/calendar.events',
          'https://www.googleapis.com/auth/calendar.events.readonly',
        ],
      );

  @override
  Future<Iterable<String>> getAccounts() async => (await _myCalendarApi.myCalendarGoogleAccounts()).data as Iterable<String>;

  @override
  Future<Iterable<String>> authenticateAccount() async {
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
        final response = await _myCalendarApi.myCalendarUpdateGoogleAccounts(
          bodyMyCalendarUpdateGoogleAccounts: (BodyMyCalendarUpdateGoogleAccountsBuilder()
                ..accessToken = accessToken
                ..email = email)
              .build(),
        );
        return response.data as Iterable<String>;
      }
    }
    return [];
  }
}
