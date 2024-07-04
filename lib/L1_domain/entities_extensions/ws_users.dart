// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/user.dart';
import '../entities/workspace.dart';

extension WSMembersExtension on Workspace {
  User? userForId(int userId) => users.firstWhereOrNull((u) => u.id == userId);
}
