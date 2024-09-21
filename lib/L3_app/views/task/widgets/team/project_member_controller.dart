// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/ws_member.dart';
import '../../../../../L1_domain/entities/ws_member_contact.dart';
import '../../../../extra/services.dart';
import '../../../_base/loadable.dart';

part 'project_member_controller.g.dart';

class ProjectMemberController extends _Base with _$ProjectMemberController {
  ProjectMemberController(WSMember member) {
    _member = member;
    reload();
  }
}

abstract class _Base with Store, Loadable {
  late final WSMember _member;

  @observable
  Iterable<WSMemberContact> contacts = [];

  @action
  Future reload() async {
    await load(() async {
      contacts = await projectMembersUC.projectMemberContacts(_member.wsId, _member.taskId ?? -1, _member.id ?? -1);
    });
  }
}
