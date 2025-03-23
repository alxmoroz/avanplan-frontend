// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/task.dart';
import '../entities/task_local_settings.dart';
import '../entities/task_settings.dart';
import '../entities_extensions/task_type.dart';

extension TaskSettingsExt on Task {
  TaskViewMode get defaultProjectViewMode =>
      isInbox ? TaskViewMode.LIST : TaskViewMode.fromString(settings.firstWhereOrNull((s) => s.code == TSCode.VIEW_MODE)?.value);
}
