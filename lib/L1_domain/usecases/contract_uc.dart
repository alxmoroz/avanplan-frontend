// Copyright (c) 2022. Alexandr Moroz

import '../entities/invoice.dart';
import '../repositories/abs_contract_repo.dart';

class ContractUC {
  ContractUC(this.repo);
  Future<ContractUC> init() async => this;

  final AbstractContractRepo repo;

  Future<Invoice?> sign(int tariffId, int wsId) async => await repo.sign(tariffId, wsId);
}
