// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';

extension WPermissionsExt on Workspace {
  /// разрешения для текущего пользователя для выбранного рабочего пространства
  User? get _user => accountController.user;

  Iterable<String> get _wP => users.firstWhereOrNull((u) => u.id == _user?.id)?.permissions ?? [];

  bool get hpMembersView => _wP.contains('MEMBERS_VIEW');
  bool get hpMembersEdit => _wP.contains('MEMBERS_EDIT');
  bool get hpProjectsView => _wP.contains('PROJECTS_VIEW');
  bool get hpProjectsEdit => _wP.contains('PROJECTS_EDIT');
  bool get hpRolesEdit => _wP.contains('ROLES_EDIT');
  bool get hpSourcesEdit => _wP.contains('SOURCES_EDIT');
  bool get hpTariffView => _wP.contains('TARIFF_VIEW');
  bool get hpTariffChange => _wP.contains('TARIFF_CHANGE');
}
