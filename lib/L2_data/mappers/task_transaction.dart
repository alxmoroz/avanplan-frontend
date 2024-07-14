// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as o_api;

import '../../L1_domain/entities/task_transaction.dart';

extension TaskTransactionMapper on o_api.TaskTransactionGet {
  TaskTransaction transaction(int wsId) => TaskTransaction(
        id: id,
        wsId: wsId,
        taskId: taskId,
        amount: amount,
        category: category ?? '',
        description: description ?? '',
        authorId: authorId,
        createdOn: createdOn.toLocal(),
      );
}
