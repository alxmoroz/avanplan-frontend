// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/number_symbols_data.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';
import '../../../../views/_base/loader_screen.dart';
import 'transaction_edit_controller.dart';

Future transactionEditDialog(Task task, {TaskTransaction? transaction}) async {
  final controller = TransactionEditController(task, transaction: transaction);
  await showMTDialog<void>(_TransactionEditDialog(controller));
}

class _TransactionEditDialog extends StatelessWidget {
  const _TransactionEditDialog(this._controller);
  final TransactionEditController _controller;

  bool get canSave => _controller.validated;

  Widget _tf(TransactionFCode code) {
    final fd = _controller.fData(code.index);
    return MTTextField(controller: _controller.teController(code.index), label: fd.label);
  }

  Future _save(BuildContext context) async {
    Navigator.of(context).pop();
    _controller.save();
  }

  @override
  Widget build(BuildContext context) {
    final decimalSep = RegExp.escape(numberFormatSymbols[languageCode]?.DECIMAL_SEP ?? '.');
    final groupSep = RegExp.escape(numberFormatSymbols[languageCode]?.GROUP_SEP ?? '.');

    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: const MTAppBar(showCloseButton: true, color: b2Color),
              body: ListView(
                shrinkWrap: true,
                children: [
                  MTTextField(
                    controller: _controller.teController(TransactionFCode.amount.index),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.end,
                    style: const D2('').style(context),
                    hint: '0',
                    hintStyle: const D2('', color: f3Color).style(context),
                    inputFormatters: [
                      // TODO: можно сделать в одной withFunction или даже вытащить в отдельный класс
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
                          final numString = newValue.text.replaceAll(groupSep, '').replaceAll(decimalSep, '.');
                          final value = num.tryParse(numString) ?? 0;
                          String formattedValue = value.currency;
                          if (newValue.text.contains(decimalSep)) {
                            formattedValue += decimalSep + newValue.text.split(',').last;
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
                  for (final code in [TransactionFCode.description, TransactionFCode.category]) _tf(code),
                  const SizedBox(height: P3),
                  MTButton.main(
                    titleText: loc.save_action_title,
                    onTap: canSave ? () => _save(context) : null,
                  ),
                  if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
                ],
              ),
            ),
    );
  }
}
