// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal.dart';

abstract class AbstractGoalsRepo {
  Future<List<Goal>> getGoals();
  Future<Goal?> saveGoal({
    required int? id,
    required String title,
    required String description,
    required DateTime dueDate,
    required int? statusId,
  });
  Future<bool> deleteGoal(int id);
}
