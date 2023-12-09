// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_project_transfer_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class ProjectTransferRepo extends AbstractProjectTransferRepo {
  o_api.TransferApi get api => openAPI.getTransferApi();

  @override
  Future<Iterable<TaskBase>> getProjectTemplates(int wsId) async {
    final response = await api.projectTemplatesV1TransferProjectTemplatesGet(wsId: wsId);
    return response.data?.map((t) => t.taskBase) ?? [];
  }

  @override
  Future<TasksChanges?> transfer(int srcWsId, int dstWsId, int projectId) {
    // TODO: implement transfer
    throw UnimplementedError();
  }
}
