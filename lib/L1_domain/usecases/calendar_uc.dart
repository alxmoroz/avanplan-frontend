// Copyright (c) 2024. Alexandr Moroz

import '../repositories/abs_calendar_repo.dart';

class CalendarUC {
  const CalendarUC({required this.googleCalendarRepo});

  final AbstractCalendarGoogleRepo googleCalendarRepo;

  Future<Iterable<String>> authenticateGoogleAccount() async => await googleCalendarRepo.authenticateAccount();
  Future<Iterable<String>> getGoogleAccounts() async => await googleCalendarRepo.getAccounts();
}
