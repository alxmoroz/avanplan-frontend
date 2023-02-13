// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';

extension TaskPermissionsExt on Workspace {
  /// разрешения для текущего пользователя для выбранного рабочего пространства
  User? get _user => accountController.user;

  Iterable<String> get _wP => users.firstWhereOrNull((u) => u.id == _user?.id)?.permissions ?? [];
  bool get hpEditProjects => _wP.contains('PROJECTS_EDIT');
  bool get hpEditSources => _wP.contains('SOURCES_EDIT');
}
