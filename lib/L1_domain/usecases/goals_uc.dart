// Copyright (c) 2022. Alexandr Moroz

import '../api_schema/goal_upsert.dart';
import '../entities/element_of_work.dart';
import '../repositories/abs_api_repo.dart';

class GoalsUC {
  GoalsUC({required this.repo});

  final AbstractApiRepo<ElementOfWork, GoalUpsert> repo;

  Future<ElementOfWork?> save(GoalUpsert data) async {
    ElementOfWork? goal;
    // TODO: внутр. exception?
    if (data.title.trim().isNotEmpty && data.dueDate != null) {
      goal = await repo.save(data);
    }
    return goal;
  }

  Future<ElementOfWork?> delete({required ElementOfWork goal}) async {
    // TODO: внутр. exception?
    goal.deleted = await repo.delete(goal.id);
    return goal;
  }
}
