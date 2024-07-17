// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/field_data.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';
import '../../../_base/edit_controller.dart';
import '../../../_base/loadable.dart';

part 'transaction_edit_controller.g.dart';

enum TransactionFCode { amount, description, category }

class TransactionEditController extends _Base with _$TransactionEditController {
  TransactionEditController(Task task, {TaskTransaction? transaction, num? trSign}) {
    taskTransaction = transaction ??
        TaskTransaction(
          wsId: task.wsId,
          taskId: task.id!,
          amount: 0,
          category: '',
          description: '',
        );

    sign = trSign ?? taskTransaction.amount.sign;

    setupFields();
    stopLoading();
  }

  void setupFields() {
    initState(fds: [
      MTFieldData(
        TransactionFCode.amount.index,
        text: taskTransaction.amount.abs().currencySharp,
        validate: true,
        validator: (text) => valueFromText(text) > 0 ? null : loc.validation_empty_text,
      ),
      MTFieldData(TransactionFCode.description.index, label: loc.finance_transactions_description_title, text: taskTransaction.description),
      MTFieldData(TransactionFCode.category.index, label: loc.finance_transactions_category_title, text: taskTransaction.category),
    ]);
  }
}

abstract class _Base extends EditController with Store, Loadable {
  late TaskTransaction taskTransaction;
  late num sign;

  num valueFromText(String text) {
    final seps = NumberSeparators();
    final numString = text.replaceAll(seps.groupSep, '').replaceAll(seps.decimalSep, '.');
    return num.tryParse(numString) ?? 0;
  }

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
      final amount = sign * valueFromText(fData(TransactionFCode.amount.index).text);
      final changes = await taskTransactionUC.save(
        TaskTransaction(
          id: taskTransaction.id,
          wsId: taskTransaction.wsId,
          taskId: taskTransaction.taskId,
          amount: amount,
          description: fData(TransactionFCode.description.index).text,
          category: fData(TransactionFCode.category.index).text,
        ),
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
