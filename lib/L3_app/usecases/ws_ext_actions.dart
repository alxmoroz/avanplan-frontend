// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WSActionsExt on Workspace {
  User? get me => users.firstWhereOrNull((u) => u.id == accountController.user?.id);

  bool get hpProjectCreate => me?.hp('PROJECT_CREATE') == true;
  bool get hpProjectUpdate => me?.hp('PROJECT_UPDATE') == true;
  bool get hpProjectDelete => me?.hp('PROJECT_DELETE') == true;
  bool get hpProjectContentUpdate => me?.hp('PROJECT_CONTENT_UPDATE') == true;
  bool get hpWSInfoRead => me?.hp('WORKSPACE_INFO_READ') == true;

  bool _pl(String code, int value) => invoice.tariff.passLimit(code, value);

  bool get plUsers => _pl('USERS_COUNT', users.length + 1);
  bool get plUnlink => _pl('PROJECTS_UNLINK_ALLOWED', 1);
  bool get plProjects => _pl('PROJECTS_COUNT', mainController.wsProjects(id!).length + 1);
  bool get plTasks => _pl('TASKS_COUNT', mainController.wsTasks(id!).length + 1);
}
