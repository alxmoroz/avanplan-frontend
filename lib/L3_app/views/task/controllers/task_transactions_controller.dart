// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_transaction.dart';
import 'task_controller.dart';

part 'task_transactions_controller.g.dart';

class TaskTransactionsController extends _Base with _$TaskTransactionsController {
  TaskTransactionsController(TaskController tcIn) {
    taskController = tcIn;
  }
}

abstract class _Base with Store {
  late final TaskController taskController;
  Task get task => taskController.task;

  @observable
  ObservableList<TaskTransaction> _transactions = ObservableList();

  @action
  void reload() => _transactions = ObservableList.of(task.transactions);

  @computed
  List<TaskTransaction> get sortedTransactions => _transactions.sorted((tr1, tr2) => tr1.compareTo(tr2));

  @computed
  num get transactionsCount => _transactions.length;
}
