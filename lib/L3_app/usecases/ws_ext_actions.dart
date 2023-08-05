// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/tariff.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WSActionsExt on Workspace {
  User get me => users.firstWhere((u) => u.id == accountController.user?.id);

  bool get hpInfoRead => me.hp('INFO_READ');
  bool get hpInfoUpdate => me.hp('INFO_UPDATE');

  bool get hpProjectCreate => me.hp('PROJECT_CREATE');
  bool get hpProjectUpdate => me.hp('PROJECT_UPDATE');
  bool get hpProjectDelete => me.hp('PROJECT_DELETE');

  bool get hpProjectContentUpdate => me.hp('PROJECT_CONTENT_UPDATE');

  bool get hpSourceCreate => me.hp('SOURCE_CREATE');

  bool get hpTariffUpdate => me.hp('TARIFF_UPDATE');

  bool get hpOwnerUpdate => me.hp('OWNER_UPDATE');
  bool get isMine => hpOwnerUpdate;

  bool _pl(String code, int value) => invoice.tariff.passLimit(code, value);

  bool get plUsers => _pl(TLCode.USERS_COUNT, users.length + 1);
  bool get plUnlink => _pl(TLCode.PROJECTS_UNLINK_ALLOWED, 1);

  int get _projectsCount => mainController.projects.where((t) => t.ws.id == id).length;
  int get maxProjects => invoice.tariff.limitValue(TLCode.PROJECTS_COUNT).toInt();
  int get availableProjectsCount => maxProjects - _projectsCount;
  bool get plProjects => availableProjectsCount > 0;

  // TODO: при добавлении и удалении задач нужно уточнять tasksCount, а лучше делать запросы на бэк дополнительные всё же и обновлять инфу о WS
  bool get plTasks => _pl(TLCode.TASKS_COUNT, tasksCount + 1);
}
