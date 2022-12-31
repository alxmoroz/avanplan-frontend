// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/event.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/usecases/task_ext_level.dart';
import '../extra/services.dart';

extension EventPresenter on Event {
  Task? get task => taskId != null ? mainController.taskForId(taskId) : null;
  String get projectTitle => task!.project?.title ?? '';
  String get title => Intl.message('${type.title}_title') + (task != null ? ': ${task!.title}' : '');
  String get _localizedEventDescription => Intl.message('${type.title}_description');
  String get localizedDescription => description ?? _localizedEventDescription;
}
