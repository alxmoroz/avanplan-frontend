// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/alert_dialog.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/number.dart';
import '../../../../views/_base/loader_screen.dart';
import 'transaction_edit_controller.dart';

Future showTransactionEditDialog(Task task, TransactionEditController trEditController) async {
  await showMTDialog(_TransactionEditDialog(task, trEditController));
}

class _TransactionEditDialog extends StatelessWidget {
  const _TransactionEditDialog(this._task, this._controller);
  final Task _task;
  final TransactionEditController _controller;

  bool get canSave => _controller.validated;
  bool get canDelete => !_controller.transaction.isNew;

  Widget _tf(TransactionFCode code) {
    final fd = _controller.fData(code.index);
    return MTTextField(controller: _controller.teController(code.index), label: fd.label);
  }

  Future _save(BuildContext context) async {
    await _controller.save();
    if (context.mounted) Navigator.of(context).pop();
  }

  Future _delete(BuildContext context) async {
    if (await showMTAlertDialog(
          title: loc.finance_transactions_delete_dialog_title,
          description: loc.delete_dialog_description,
          actions: [
            MTDialogAction(title: loc.action_yes_delete_title, type: ButtonType.danger, result: true),
            MTDialogAction(title: loc.action_no_dont_delete_title, result: false),
          ],
        ) ==
        true) {
      await _controller.delete();
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  Widget _dialog(BuildContext context) {
    final seps = NumberSeparators();
    final groupSep = seps.groupSep;
    final decimalSep = seps.decimalSep;
    final textColor = _controller.sign > 0 ? greenColor : dangerColor;
    return MTDialog(
      topBar: MTTopBar(
        pageTitle:
            '${_controller.sign > 0 ? loc.finance_transactions_income_title(1) : loc.finance_transactions_expenses_title(1)} ${_controller.transaction.createdOn?.strMedium}',
        parentPageTitle: _task.title,
        trailing: canDelete ? MTButton.icon(const DeleteIcon(), onTap: () => _delete(context), padding: const EdgeInsets.all(P2)) : null,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTTextField(
            controller: _controller.teController(TransactionFCode.amount.index),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0',
              hintStyle: const D2('', color: f3Color).style(context),
              suffixIcon: const D2(CURRENCY_SYMBOL_ROUBLE, color: f3Color),
              // для компенсации выравнивания по центру из-за suffixIcon
              prefixIcon: const D2(' ', color: f3Color),
              contentPadding: EdgeInsets.zero,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: D2('', color: textColor).style(context),
            cursorColor: textColor,
            inputFormatters: [
              // TODO: можно сделать в одной withFunction или даже вытащить в отдельный класс
              LengthLimitingTextInputFormatter(19),
              FilteringTextInputFormatter.deny(RegExp(groupSep)),
              FilteringTextInputFormatter.deny(RegExp('^$decimalSep'), replacementString: '0$decimalSep'),
              FilteringTextInputFormatter.allow(RegExp('^\\d{0,}$decimalSep?\\d{0,2}')),
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.startsWith(RegExp(r'^0+\d+'))) {
                  newValue = newValue.copyWith(
                    text: newValue.text.replaceFirst(RegExp(r'0*'), ''),
                    selection: const TextSelection.collapsed(offset: -1),
                  );
                }
                return newValue;
              }),
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.isNotEmpty) {
                  String formattedValue = _controller.valueFromText(newValue.text).currencySharp;
                  final formattedIsFloat = formattedValue.lastIndexOf(decimalSep) > -1;
                  if (newValue.text.contains(decimalSep) && !formattedIsFloat) {
                    formattedValue += decimalSep + newValue.text.split(decimalSep).last;
                  }
                  final selectionOffset = newValue.selection.baseOffset + (formattedValue.length - newValue.text.length);
                  newValue = newValue.copyWith(
                    text: formattedValue,
                    selection: TextSelection.collapsed(offset: selectionOffset),
                  );
                }

                return newValue;
              }),
            ],
          ),
          for (final code in [TransactionFCode.category, TransactionFCode.description]) _tf(code),
          MTButton.main(
            titleText: loc.action_save_title,
            margin: const EdgeInsets.only(top: P3),
            onTap: canSave ? () => _save(context) : null,
          ),
        ],
      ),
      forceBottomPadding: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading ? LoaderScreen(_controller, isDialog: true) : _dialog(context),
    );
  }
}
