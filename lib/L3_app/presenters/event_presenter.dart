// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/event.dart';

extension EventPresenter on Event {
  // Task? get task => taskId != null ? mainController.taskForId(taskId) : null;
  // String get projectTitle => task!.project?.title ?? '';
  // String get title => Intl.message('event_${type.code}_title') + (task != null ? ': ${task!.title}' : '');
  String get _localizedEventDescription => Intl.message('event_${type.code}_description');
  // String get localizedDescription => description ?? _localizedEventDescription;
}
