// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WActionsExt on Workspace {
  User? get me => users.firstWhereOrNull((u) => u.id == accountController.user?.id);

  bool get hpProjectCreate => me?.hp('PROJECT_CREATE') == true;
  bool get hpProjectUpdate => me?.hp('PROJECT_UPDATE') == true;
  bool get hpProjectDelete => me?.hp('PROJECT_DELETE') == true;
  bool get hpProjectUnlink => hpProjectUpdate && invoice.tariff.limitValue('PROJECTS_UNLINK_ALLOWED') == 1;
  bool get hpProjectContentUpdate => me?.hp('PROJECT_CONTENT_UPDATE') == true;
  bool get hpWSInfoRead => me?.hp('WORKSPACE_INFO_READ') == true;
}
