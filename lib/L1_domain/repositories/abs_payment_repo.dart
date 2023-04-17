// Copyright (c) 2022. Alexandr Moroz

abstract class AbstractPaymentRepo {
  Future<bool> ymQuickPayForm(num amount, int wsId, int userId);
}
