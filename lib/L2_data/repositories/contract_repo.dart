// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/invoice.dart';
import '../../L1_domain/repositories/abs_contract_repo.dart';
import '../mappers/invoice.dart';
import '../services/api.dart';

class ContractRepo extends AbstractContractRepo {
  o_api.ContractsApi get api => openAPI.getContractsApi();

  @override
  Future<Invoice?> sign(int tariffId, int wsId) async {
    final response = await api.signContract(tariffId: tariffId, wsId: wsId);
    return response.data?.invoice;
  }
}
