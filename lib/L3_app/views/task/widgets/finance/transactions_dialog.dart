// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_transactions_controller.dart';

Future transactionsDialog(TaskTransactionsController controller) async => await showMTDialog<void>(_TransactionsDialog(controller));

class _TransactionsDialog extends StatelessWidget {
  const _TransactionsDialog(this._controller);
  final TaskTransactionsController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.tariff_option_finance_title),
      body: Observer(
        builder: (_) => MTShadowed(
          topPaddingIndent: 0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.sortedTransactions.length,
            itemBuilder: (_, index) {
              final tr = _controller.sortedTransactions[index];
              return MTListTile(
                // leading: MimeTypeIcon(a.type),
                titleText: tr.description,
                subtitle: SmallText(tr.category, maxLines: 1),
                dividerIndent: P6 + P5,
                bottomDivider: index < _controller.sortedTransactions.length - 1,
                onTap: () async {
                  if (_controller.sortedTransactions.length < 2) Navigator.of(context).pop();
                  // await _controller.download(tr);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
