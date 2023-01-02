// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/workspace.dart';

extension WorkspacePresenter on Workspace {
  String get rolesList => roles.map((r) => Intl.message('role_${r.code}')).join(', ');
}
