// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/field_data.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';
import '../../../_base/edit_controller.dart';
import '../../../_base/loadable.dart';

part 'transaction_edit_controller.g.dart';

enum TransactionFCode { amount, category, description }

class TransactionEditController extends _Base with _$TransactionEditController {
  TransactionEditController(this.transaction, this.sign) {
    _setupFields();
    stopLoading();
  }

  final TaskTransaction transaction;
  final num sign;

  void _setupFields() {
    initState(fds: [
      MTFieldData(
        TransactionFCode.amount.index,
        text: transaction.amount.abs().currencySharp,
        validate: true,
        validator: (text) => valueFromText(text) > 0 ? null : loc.validation_empty_text,
      ),
      MTFieldData(TransactionFCode.description.index, label: loc.finance_transactions_description_title, text: transaction.description),
      MTFieldData(TransactionFCode.category.index, label: loc.finance_transactions_category_title, text: transaction.category),
    ]);
  }

  num valueFromText(String text) {
    final seps = NumberSeparators();
    final numString = text.replaceAll(seps.groupSep, '').replaceAll(seps.decimalSep, '.');
    return num.tryParse(numString) ?? 0;
  }

  Future _editWrapper(Function() function) async {
    transaction.loading = true;
    tasksMainController.refreshUI();

    await load(function);

    transaction.loading = false;
    tasksMainController.refreshUI();
  }

  Future save() async {
    setLoaderScreenSaving();

    await _editWrapper(() async {
      transaction.amount = sign * valueFromText(fData(TransactionFCode.amount.index).text);
      transaction.category = fData(TransactionFCode.category.index).text;
      transaction.description = fData(TransactionFCode.description.index).text;

      final changes = await taskTransactionsUC.save(transaction);
      if (changes != null) {
        tasksMainController.upsertTasks([changes.updated, ...changes.affected]);
      }
    });

    // if (transactionsWidgetGlobalKey.currentContext?.mounted == true) {
    //   Scrollable.ensureVisible(transactionsWidgetGlobalKey.currentContext!);
    // }
  }

  Future delete() async {
    setLoaderScreenDeleting();

    await _editWrapper(() async {
      final changes = await taskTransactionsUC.delete(transaction);
      if (changes != null) {
        tasksMainController.upsertTasks([changes.updated, ...changes.affected]);
      }
    });
  }
}

abstract class _Base extends EditController with Store, Loadable {}
