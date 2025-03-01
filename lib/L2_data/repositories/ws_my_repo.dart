// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan_api/avanplan_api.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/repositories/abs_ws_my_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class WSMyRepo extends AbstractWSMyRepo {
  o_api.WSMyApi get _api => avanplanApi.getWSMyApi();

  @override
  Future<Iterable<Task>> myTasks(int wsId, {int? projectId}) async {
    final response = await _api.myTasks(wsId: wsId, projectId: projectId);
    return response.data?.map((t) => t.task(wsId)) ?? [];
  }

  @override
  Future<Iterable<Task>> myProjects(int wsId, {bool? closed, bool? imported}) async {
    final response = await _api.myProjects(wsId: wsId, closed: closed, imported: imported);
    return response.data?.map((t) => t.task(wsId)) ?? [];
  }
}
