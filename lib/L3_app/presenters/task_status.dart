// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/usecases/task_tree.dart';

import '../../L1_domain/entities/task.dart';

extension TaskStatusPresenter on Task {
  String get projectStatusesStr => project?.projectStatuses.map((s) => s.title).join(', ') ?? '';
}
