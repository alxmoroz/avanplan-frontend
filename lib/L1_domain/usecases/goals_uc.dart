// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/goal_upsert.dart';
import '../entities/goal.dart';
import '../repositories/abs_api_repo.dart';

class GoalsUC {
  GoalsUC({required this.repo});

  final AbstractApiRepo<Goal, GoalUpsert> repo;

  Future<Goal?> save(GoalUpsert data) async {
    Goal? goal;
    // TODO: внутр. exception?
    if (data.title.trim().isNotEmpty && data.dueDate != null) {
      goal = await repo.save(data);
    }
    return goal;
  }

  Future<Goal?> delete({required Goal goal}) async {
    // TODO: внутр. exception?
    goal.deleted = await repo.delete(goal.id);
    return goal;
  }
}
