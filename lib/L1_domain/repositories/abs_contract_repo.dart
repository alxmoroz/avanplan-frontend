// Copyright (c) 2022. Alexandr Moroz

import '../entities/invoice.dart';

abstract class AbstractContractRepo {
  Future<Invoice?> sign(int tariffId, int wsId);
}
