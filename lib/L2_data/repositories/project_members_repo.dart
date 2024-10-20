// Copyright (c) 2024. Alexandr Moroz

import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/ws_member.dart';
import '../../L1_domain/entities/ws_member_contact.dart';
import '../../L1_domain/repositories/abs_project_members_repo.dart';
import '../../L2_data/mappers/ws_member.dart';
import '../../L2_data/mappers/ws_member_contact.dart';
import '../services/api.dart';

class ProjectMembersRepo extends AbstractProjectMembersRepo {
  o_api.ProjectMembersApi get _api => openAPI.getProjectMembersApi();

  @override
  Future<Iterable<WSMember>> assignProjectMemberRoles(int wsId, int taskId, int memberId, Iterable<int> rolesIds) async {
    final response = await _api.assignProjectMemberRoles(
      taskId: taskId,
      memberId: memberId,
      wsId: wsId,
      requestBody: BuiltList.of(rolesIds),
    );
    return response.data?.map((m) => m.wsMember(wsId)) ?? [];
  }

  @override
  Future<Iterable<WSMemberContact>> memberContacts(int wsId, int taskId, int memberId) async {
    final response = await _api.projectMemberContacts(wsId: wsId, taskId: taskId, memberId: memberId);
    return response.data?.map((contact) => contact.memberContact) ?? [];
  }
}
