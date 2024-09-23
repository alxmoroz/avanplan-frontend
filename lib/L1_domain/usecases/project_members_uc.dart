// Copyright (c) 2024. Alexandr Moroz

import '../entities/ws_member.dart';
import '../entities/ws_member_contact.dart';
import '../repositories/abs_project_members_repo.dart';

class ProjectMembersUC {
  ProjectMembersUC(this.repo);

  final AbstractProjectMembersRepo repo;

  Future<Iterable<WSMember>> assignMemberRoles(int wsId, int projectId, int memberId, Iterable<int> rolesIds) async =>
      await repo.assignProjectMemberRoles(wsId, projectId, memberId, rolesIds);

  Future<Iterable<WSMemberContact>> memberContacts(int wsId, int projectId, int memberId) async =>
      await repo.memberContacts(wsId, projectId, memberId);
}
