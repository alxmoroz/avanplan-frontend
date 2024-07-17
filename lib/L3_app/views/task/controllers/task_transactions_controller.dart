// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_transaction.dart';
import '../../../../L1_domain/utils/dates.dart';
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
  List<TaskTransaction> get _sortedTransactions => _transactions.sorted((tr1, tr2) => tr1.compareTo(tr2));
  @computed
  Map<DateTime, List<TaskTransaction>> get transactionsGroups => _sortedTransactions.groupListsBy((tr) => tr.createdOn!.date);
  @computed
  List<DateTime> get sortedTransactionsDates => transactionsGroups.keys.sorted((d1, d2) => d2.compareTo(d1));

  @computed
  num get transactionsCount => _transactions.length;
}
