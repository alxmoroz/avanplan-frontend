// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/source.dart';
import '../entities/workspace.dart';

extension WSExtension on Workspace {
  Source? sourceForId(int? id) => sources.firstWhereOrNull((s) => s.id == id);
  Source? sourceForType(String? type) => sources.firstWhereOrNull((s) => s.type == type);
}
