// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import 'date_presenter.dart';

extension TaskDatePresenter on Task {
  String get dueDateStrLong => dueDate != null ? dueDate!.strLong : '';
  String get startDateStrLong => startDate != null ? startDate!.strLong : '';
}
