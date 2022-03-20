// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import 'buttons.dart';
import 'card.dart';
import 'constants.dart';
import 'icons.dart';
import 'text_widgets.dart';

Future showDetailsDialog(BuildContext context, String text) async {
  await showDialog<void>(
    context: context,
    builder: (_) => MTDetailsDialog(description: text),
  );
}

class MTDetailsDialog extends StatelessWidget {
  const MTDetailsDialog({this.description = ''});

  final String description;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Center(
      child: MTCard(
        title: Row(children: [const Spacer(), Button.icon(closeIcon(context), () => Navigator.of(context).pop())]),
        body: Container(
          constraints: BoxConstraints(maxHeight: mq.size.height - mq.viewInsets.bottom - mq.viewPadding.bottom - 180),
          child: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(onePadding),
              child: NormalText(description),
            ),
          ),
        ),
      ),
    );
  }
}
