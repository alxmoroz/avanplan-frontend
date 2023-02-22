// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../extra/services.dart';

extension WActionsExt on Workspace {
  /// разрешения для текущего пользователя для выбранного рабочего пространства
  User? get _user => accountController.user;

  User? get me => users.firstWhereOrNull((u) => u.id == _user?.id);

  Iterable<String> get _wP => me?.permissions ?? [];

  bool get _hpMembersView => _wP.contains('MEMBERS_VIEW');
  // bool get _hpMembersEdit => _wP.contains('MEMBERS_EDIT');
  // bool get _hpProjectsView => _wP.contains('PROJECTS_VIEW');
  bool get _hpProjectsEdit => _wP.contains('PROJECTS_EDIT');
  // bool get _hpRolesEdit => _wP.contains('ROLES_EDIT');
  // bool get _hpSourcesEdit => _wP.contains('SOURCES_EDIT');
  bool get _hpTariffView => _wP.contains('TARIFF_VIEW');
  // bool get _hpTariffChange => _wP.contains('TARIFF_CHANGE');

  bool get canProjectsEdit => _hpProjectsEdit;
  bool get canWSView => _hpMembersView || _hpTariffView;

  /// доступные пользователи для добавления в проект
  Iterable<User> get allowedUsers => _hpMembersView ? users : [];
}
