// Copyright (c) 2022. Alexandr Moroz

import '../entities/goals/goal.dart';
import '../repositories/abstract_goals_repo.dart';

class GoalsUC {
  GoalsUC({required this.repo});

  final AbstractGoalsRepo repo;

  Future<List<Goal>> getGoals() async {
    final goals = await repo.getGoals();
    return goals;
  }

  Future<Goal?> saveGoal({
    required int? id,
    required String title,
    required String description,
    required DateTime? dueDate,
  }) async {
    Goal? goal;
    // TODO: внутр. exception?
    if (title.trim().isNotEmpty && dueDate != null) {
      goal = await repo.saveGoal(id: id, title: title, description: description, dueDate: dueDate);
    }
    return goal;
  }

  Future<Goal?> deleteGoal(Goal goal) async {
    final deletedRows = await repo.deleteGoal(goal.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      goal.deleted = true;
    }
    return goal;
  }
}
