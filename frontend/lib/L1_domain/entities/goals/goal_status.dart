// Copyright (c) 2022. Alexandr Moroz

import '../base_entity.dart';

class GoalStatus extends Statusable {
  GoalStatus({
    required int id,
    required String title,
    required bool closed,
  }) : super(id: id, title: title, closed: closed);
}
