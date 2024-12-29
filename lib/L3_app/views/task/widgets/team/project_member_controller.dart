// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/ws_member.dart';
import '../../../../../L1_domain/entities/ws_member_contact.dart';
import '../../../../../L1_domain/entities_extensions/contact.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../_base/loadable.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/members.dart';

part 'project_member_controller.g.dart';

class ProjectMemberController extends _Base with _$ProjectMemberController {
  ProjectMemberController(TaskController tc, int memberId) {
    _tc = tc;
    _memberId = memberId;
    reload();
  }

  void setAssigneeFilter() => _tc.settingsController.setAssigneeFilter(_memberId);
  Future assignRole(int roleId) async => await _tc.assignMemberRoles(_memberId, [roleId]);
  Future unlinkRole() async => await _tc.assignMemberRoles(_memberId, []);
}

abstract class _Base with Store, Loadable {
  late final TaskController _tc;
  late final int _memberId;

  Task get project => _tc.task;
  WSMember? get projectMember => project.taskMemberForId(_memberId);

  @observable
  Iterable<WSMemberContact> contacts = [];

  @computed
  Iterable<WSMemberContact> get emails => contacts.where((c) => c.mayBeEmail);
  @computed
  WSMemberContact? get firstEmail => emails.firstOrNull;

  @computed
  Iterable<WSMemberContact> get phones => contacts.where((c) => c.mayBePhone);
  @computed
  WSMemberContact? get firstPhone => phones.firstOrNull;

  @computed
  Iterable<WSMemberContact> get urls => contacts.where((c) => c.mayBeUrl);
  @computed
  WSMemberContact? get firstUrl => urls.firstOrNull;

  @computed
  Iterable<WSMemberContact> get others => contacts.where((c) => c.other);

  @computed
  bool get hasDupInTypes => emails.length > 1 || phones.length > 1 || urls.length > 1;

  @computed
  bool get onlyOthers => contacts.length == others.length;
  @computed
  bool get needShowAll => hasDupInTypes || contacts.length > 3 || onlyOthers;

  @action
  Future reload() async {
    setLoaderScreenLoading();
    await load(() async {
      contacts = await projectMembersUC.memberContacts(project.wsId, project.id!, _memberId);
    });
  }
}
