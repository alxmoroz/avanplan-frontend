// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../entities/goals/goal.dart';
import '../repositories/abs_api_repo.dart';

class GoalsUC {
  GoalsUC({required this.repo});

  final AbstractApiRepo<Goal> repo;

  Future<List<Goal>> getAll() async {
    return await repo.getAll();
  }

  Future<Goal?> save({
    required int? id,
    required String title,
    required String description,
    required DateTime? dueDate,
    required int? statusId,
  }) async {
    Goal? goal;
    // TODO: внутр. exception?
    if (title.trim().isNotEmpty && dueDate != null) {
      final builder = GoalSchemaUpsertBuilder()
        ..id = id
        ..statusId = statusId
        ..title = title
        ..description = description
        ..dueDate = dueDate.toUtc();

      goal = await repo.save(builder.build());
    }
    return goal;
  }

  Future<Goal?> delete({required Goal goal}) async {
    final deletedRows = await repo.delete(goal.id);
    // TODO: внутр. exception?
    if (deletedRows) {
      goal.deleted = true;
    }
    return goal;
  }
}
