// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_transaction.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/text_field.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
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

    return MTTextField(
      controller: _controller.teController(code.index),
      label: fd.label,
      margin: tfPadding.copyWith(top: code == TransactionFCode.description ? P : tfPadding.top),
    );
  }

  Future _save(BuildContext context) async {
    Navigator.of(context).pop();
    _controller.save();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: const MTAppBar(showCloseButton: true, color: b2Color),
              body: ListView(
                shrinkWrap: true,
                children: [
                  for (final code in TransactionFCode.values) _tf(code),
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
