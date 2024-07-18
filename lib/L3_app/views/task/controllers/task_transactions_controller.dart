// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_transaction.dart';
import '../../../../L1_domain/utils/dates.dart';
import '../widgets/finance/transaction_edit_controller.dart';
import '../widgets/finance/transaction_edit_dialog.dart';
import 'task_controller.dart';

part 'task_transactions_controller.g.dart';

class TaskTransactionsController extends _Base with _$TaskTransactionsController {
  TaskTransactionsController(this.taskController);
  final TaskController taskController;

  Task get task => taskController.task;

  void reload() => _reloadTransactions(task.transactions);

  Future _editTransaction(TaskTransaction transaction, num sign) async {
    final trEditController = TransactionEditController(transaction, sign);
    await transactionEditDialog(task, trEditController);
    reload();
  }

  TaskTransaction get _newTransaction => TaskTransaction(
        wsId: task.wsId,
        taskId: task.id!,
        createdOn: now,
        amount: 0.0,
        category: '',
        description: '',
      );

  Future addIncome() async => await _editTransaction(_newTransaction, 1);
  Future addExpense() async => await _editTransaction(_newTransaction, -1);
  Future editTransaction(TaskTransaction transaction) async => await _editTransaction(transaction, transaction.amount.sign);
}

abstract class _Base with Store {
  @observable
  ObservableList<TaskTransaction> _transactions = ObservableList();

  @action
  void _reloadTransactions(Iterable<TaskTransaction> transactions) => _transactions = ObservableList.of(transactions);

  @computed
  List<TaskTransaction> get _sortedTransactions => _transactions.sorted((tr1, tr2) => tr1.compareTo(tr2));
  @computed
  Map<DateTime, List<TaskTransaction>> get transactionsGroups => _sortedTransactions.groupListsBy((tr) => tr.createdOn!.date);
  @computed
  List<DateTime> get sortedTransactionsDates => transactionsGroups.keys.sorted((d1, d2) => d2.compareTo(d1));

  @computed
  num get transactionsCount => _transactions.length;
}
