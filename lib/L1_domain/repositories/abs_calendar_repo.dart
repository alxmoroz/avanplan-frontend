// Copyright (c) 2024. Alexandr Moroz

abstract class AbstractCalendarGoogleRepo {
  Future<Iterable<String>> authenticateAccount();
  Future<Iterable<String>> getAccounts();
}
