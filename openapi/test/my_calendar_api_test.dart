// Copyright (c) 2024. Alexandr Moroz

import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for MyCalendarApi
void main() {
  final instance = Openapi().getMyCalendarApi();

  group(MyCalendarApi, () {
    // Google Accounts
    //
    //Future<BuiltList<String>> myCalendarGoogleAccounts() async
    test('test myCalendarGoogleAccounts', () async {
      // TODO
    });

    // Update Google Accounts
    //
    //Future<BuiltList<String>> myCalendarUpdateGoogleAccounts(BodyMyCalendarUpdateGoogleAccounts bodyMyCalendarUpdateGoogleAccounts) async
    test('test myCalendarUpdateGoogleAccounts', () async {
      // TODO
    });
  });
}
