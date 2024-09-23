// Copyright (c) 2024. Alexandr Moroz

import '../entities/ws_member.dart';
import '../entities/ws_member_contact.dart';

abstract class AbstractProjectMembersRepo {
  Future<Iterable<WSMember>> assignProjectMemberRoles(int wsId, int taskId, int memberId, Iterable<int> rolesIds) async => throw UnimplementedError();
  Future<Iterable<WSMemberContact>> memberContacts(int wsId, int taskId, int memberId) async => throw UnimplementedError();
}
