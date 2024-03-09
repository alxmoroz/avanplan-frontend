// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/member.dart';
import '../entities/workspace.dart';

extension WSMembersExtension on Workspace {
  WSMember? memberForId(int? id) => members.firstWhereOrNull((m) => m.id == id);
}
