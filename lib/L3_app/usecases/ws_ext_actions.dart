// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/tariff.dart';
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
  bool get hpWSInfoUpdate => me?.hp('WORKSPACE_INFO_UPDATE') == true;
  bool get hpTariffUpdate => me?.hp('TARIFF_UPDATE') == true && serviceSettingsController.passAppleCheat;

  bool _pl(String code, int value) => invoice.tariff.passLimit(code, value);

  bool get plUsers => _pl(TLCode.USERS_COUNT, users.length + 1);
  bool get plUnlink => _pl(TLCode.PROJECTS_UNLINK_ALLOWED, 1);

  int get _projectsCount => mainController.wsProjects(id!).length;
  num get maxProjects => invoice.tariff.limitValue(TLCode.PROJECTS_COUNT);
  num get availableProjectsCount => maxProjects - _projectsCount;
  bool get plProjects => availableProjectsCount > 0;

  bool get plTasks => _pl(TLCode.TASKS_COUNT, mainController.wsTasks(id!).length + 1);
}
