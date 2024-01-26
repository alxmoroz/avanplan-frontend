// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WSActionsUC on Workspace {
  User get me => users.firstWhereOrNull((u) => u.id == accountController.user?.id) ?? User.dummy;

  // bool get hpInfoRead => me.hp('INFO_READ');
  bool get hpInfoUpdate => me.hp('INFO_UPDATE');

  bool get hpProjectCreate => me.hp('PROJECT_CREATE');
  bool get hpProjectUpdate => me.hp('PROJECT_UPDATE');
  bool get hpProjectDelete => me.hp('PROJECT_DELETE');

  bool get hpProjectContentUpdate => me.hp('PROJECT_CONTENT_UPDATE');

  bool get hpSourceCreate => me.hp('SOURCE_CREATE');
  bool get hpTariffUpdate => me.hp('TARIFF_UPDATE');

  bool get hpMemberRead => me.hp('MEMBER_READ');
  bool get hpOwnerUpdate => me.hp('OWNER_UPDATE');
  bool get isMine => hpOwnerUpdate;

  // bool _pl(String code, num value) => invoice.tariff.passLimit(code, value);
  // bool get plUsers => _pl(TLCode.USERS_COUNT, users.length + 1);
  // bool get plTasks => _pl(TLCode.TASKS_COUNT, tasksCount + 1);
  // bool get plStorage => _pl(TLCode.FS_VOLUME, fsVolume + 1);
}
