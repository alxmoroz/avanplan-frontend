// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities/task_source.dart';

TaskSourceState? tsStateFromStr(String? strState) => TaskSourceState.values.firstWhereOrNull((s) => s.name == strState);

extension TaskSourceExtension on TaskSource {
  bool get isRunning => [TaskSourceState.UNKNOWN, TaskSourceState.IMPORTING].contains(state);
  bool get hasError => [TaskSourceState.ERROR].contains(state);
  bool get isOk => [TaskSourceState.OK].contains(state);
}
