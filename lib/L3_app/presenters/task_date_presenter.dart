// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import 'date_presenter.dart';

extension TaskDatePresenter on Task {
  String get dueDateStr => dueDate != null ? dueDate!.strMedium : '';
  String get startDateStr => startDate != null ? startDate!.strMedium : '';
}
