// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_transaction.dart';
import '../../L1_domain/repositories/abs_api_repo.dart';
import '../mappers/task.dart';
import '../services/api.dart';

class TaskTransactionRepo extends AbstractApiRepo<TasksChanges, TaskTransaction> {
  o_api.TaskTransactionsApi get api => openAPI.getTaskTransactionsApi();

  @override
  Future<TasksChanges?> save(TaskTransaction data) async {
    final b = o_api.TaskTransactionUpsertBuilder()
      ..id = data.id
      // костыль для логики копирования при переносе задач
      ..createdOn = data.createdOn?.toUtc()
      ..taskId = data.taskId
      ..amount = data.amount
      ..category = data.category
      ..description = data.description;

    final changes = (await api.upsertTransaction(
      wsId: data.wsId,
      taskId: data.taskId,
      taskTransactionUpsert: b.build(),
    ))
        .data;

    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(data.wsId),
            changes.affectedTasks.map((t) => t.task(data.wsId)),
          )
        : null;
  }

  @override
  Future<TasksChanges?> delete(TaskTransaction data) async {
    final changes = (await api.deleteTransaction(
      wsId: data.wsId,
      taskId: data.taskId,
      transactionId: data.id!,
    ))
        .data;

    return changes != null
        ? TasksChanges(
            changes.updatedTask.task(data.wsId),
            changes.affectedTasks.map((t) => t.task(data.wsId)),
          )
        : null;
  }
}
