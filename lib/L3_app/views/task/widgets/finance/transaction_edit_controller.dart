// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L1_domain/utils/dates.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/field_data.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';
import '../../../_base/edit_controller.dart';
import '../../../_base/loadable.dart';

part 'transaction_edit_controller.g.dart';

enum TransactionFCode { amount, category, description }

class TransactionEditController extends _Base with _$TransactionEditController {
  TransactionEditController(Task taskIn, {TaskTransaction? transaction, num? trSign}) {
    task = taskIn;
    taskTransaction = transaction ??
        TaskTransaction(
          wsId: task.wsId,
          taskId: task.id!,
          createdOn: now,
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
  late final Task task;
  late final TaskTransaction taskTransaction;
  late final num sign;

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
      taskTransaction.amount = sign * valueFromText(fData(TransactionFCode.amount.index).text);
      taskTransaction.category = fData(TransactionFCode.category.index).text;
      taskTransaction.description = fData(TransactionFCode.description.index).text;

      final changes = await taskTransactionUC.save(taskTransaction);
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
