// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/ws_member.dart';
import '../../../../../L1_domain/entities/ws_member_contact.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../extra/services.dart';
import '../../../_base/loadable.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/members.dart';
import '../view_settings/view_settings_controller.dart';

part 'project_member_controller.g.dart';

class ProjectMemberController extends _Base with _$ProjectMemberController {
  ProjectMemberController(TaskController tc, int memberId) {
    _tc = tc;
    _memberId = memberId;
    reload();
  }

  void setAssigneeFilter() => TaskViewSettingsController(_tc).setAssigneeFilter(_memberId);
  Future assignRole(int roleId) async => await _tc.assignMemberRoles(_memberId, [roleId]);
  Future unlinkRole() async => await _tc.assignMemberRoles(_memberId, []);
}

abstract class _Base with Store, Loadable {
  late final TaskController _tc;
  late final int _memberId;

  Task get project => _tc.task;
  WSMember? get projectMember => project.taskMemberForId(_memberId);

  @observable
  Iterable<WSMemberContact> _allContacts = [];

  @computed
  List<WSMemberContact> get shortlistContacts => _allContacts.where((c) => true).toList();

  @action
  Future reload() async {
    await load(() async {
      _allContacts = [
        WSMemberContact(id: -1, value: projectMember!.email, memberId: _memberId),
        ...await projectMembersUC.memberContacts(project.wsId, project.id!, _memberId),
      ];
    });
  }
}
