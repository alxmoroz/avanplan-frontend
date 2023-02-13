// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/usecases/task_ext_level.dart';
import '../../../L1_domain/usecases/task_ext_members.dart';
import '../../extra/services.dart';
import '../workspace/ws_ext_permissions.dart';

extension TaskPermissionsExt on Task {
  /// разрешения для текущего пользователя для выбранной задачи или проекта
  User? get _user => accountController.user;

  Iterable<String> get _tP => projectMembers.firstWhereOrNull((m) => m.userId == _user?.id)?.permissions ?? [];
  bool get hpEdit => _tP.contains('TASKS_EDIT') || projectWs?.hpEditProjects == true;
  bool get hpEditMembers => _tP.contains('MEMBERS_EDIT') || projectWs?.hpEditProjects == true;
}
