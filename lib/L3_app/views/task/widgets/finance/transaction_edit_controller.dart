// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/field_data.dart';
import '../../../../extra/services.dart';
import '../../../_base/edit_controller.dart';
import '../../../_base/loadable.dart';

part 'transaction_edit_controller.g.dart';

enum TransactionFCode { description, category, amount }

class TransactionEditController extends _Base with _$TransactionEditController {
  TransactionEditController(Task task, {TaskTransaction? transaction}) {
    taskTransaction = transaction ??
        TaskTransaction(
          wsId: task.wsId,
          taskId: task.id!,
          amount: 0,
          category: '',
          description: '',
        );
    setupFields();
    stopLoading();

    print('loc.transaction_description');
    print('loc.transaction_category');
    print('loc.transaction_amount');
  }

  void setupFields() => initState(fds: [
        MTFieldData(TransactionFCode.description.index, label: 'loc.transaction_description', text: taskTransaction.description),
        MTFieldData(TransactionFCode.category.index, label: "loc.transaction_category", text: taskTransaction.category),
        MTFieldData(TransactionFCode.amount.index, label: 'loc.transaction_amount', text: taskTransaction.amount.toString(), validate: true),
      ]);
}

abstract class _Base extends EditController with Store, Loadable {
  late TaskTransaction taskTransaction;

  Future _editWrapper(Function() function) async {
    taskTransaction.loading = true;
    tasksMainController.refreshUI();

    await load(function);

    taskTransaction.loading = false;
    tasksMainController.refreshUI();
  }

  Future save() async {
    setLoaderScreenSaving();

    await _editWrapper(() async {
      final changes = await taskTransactionUC.save(
        TaskTransaction(
            id: taskTransaction.id,
            wsId: taskTransaction.wsId,
            taskId: taskTransaction.taskId,
            description: fData(TransactionFCode.description.index).text,
            category: fData(TransactionFCode.category.index).text,
            amount: num.tryParse(fData(TransactionFCode.amount.index).text) ?? 0),
      );

      if (changes != null) {
        tasksMainController.setTasks([changes.updated, ...changes.affected]);
      }
    });

    // if (transactionsWidgetGlobalKey.currentContext?.mounted == true) {
    //   Scrollable.ensureVisible(transactionsWidgetGlobalKey.currentContext!);
    // }
  }

  Future delete() async {
    await _editWrapper(() async {
      final changes = await taskTransactionUC.delete(taskTransaction);
      if (changes != null) {
        tasksMainController.setTasks([changes.updated, ...changes.affected]);
      }
    });
  }
}
