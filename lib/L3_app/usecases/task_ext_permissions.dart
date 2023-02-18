// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/usecases/task_ext_level.dart';
import '../../L1_domain/usecases/task_ext_members.dart';
import '../extra/services.dart';
import 'ws_ext_permissions.dart';

extension TaskPermissionsExt on Task {
  /// разрешения для текущего пользователя для выбранной задачи или проекта
  User? get _user => accountController.user;

  bool get hpEditProjects => projectWs?.hpProjectsEdit == true;

  Iterable<String> get _tP => projectMembers.firstWhereOrNull((m) => m.userId == _user?.id)?.permissions ?? [];
  bool get hpViewMembers => _tP.contains('MEMBERS_VIEW') || hpEditProjects;
  bool get hpEditMembers => _tP.contains('MEMBERS_EDIT') || hpEditProjects;
  bool get hpView => _tP.contains('TASKS_VIEW') || hpEditProjects;
  bool get hpEdit => _tP.contains('TASKS_EDIT') || hpEditProjects;
  bool get hpRolesEdit => _tP.contains('ROLES_EDIT') || hpEditProjects;
}
