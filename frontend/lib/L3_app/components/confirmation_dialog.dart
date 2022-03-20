// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'text_widgets.dart';

class MTDialogAction<T> {
  MTDialogAction({
    required this.title,
    required this.result,
    this.isDefault = false,
    this.isDestructive = false,
    this.onTap,
  });

  final String title;
  final T result;
  VoidCallback? onTap;
  final bool isDefault;
  final bool isDestructive;
}

Future<T?> showMTDialog<T>(
  BuildContext context, {
  required String title,
  required List<MTDialogAction<T>> actions,
  String description = '',
}) async {
  return await showCupertinoDialog<T?>(
    context: context,
    barrierDismissible: true,
    builder: (_) => MTConfirmDialog(title: title, description: description, actions: actions),
  );
}

class MTConfirmDialog extends StatelessWidget {
  const MTConfirmDialog({
    required this.title,
    required this.actions,
    this.description = '',
  });

  final String title;
  final List<MTDialogAction> actions;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: H3(title),
      content: description.isNotEmpty ? NormalText(description) : null,
      actions: actions
          .map((a) => CupertinoDialogAction(
                child: NormalText(
                  a.title,
                  color: a.isDestructive
                      ? dangerColor
                      : a.isDefault
                          ? mainColor
                          : null,
                ),
                isDefaultAction: a.isDefault,
                onPressed: a.onTap ?? () => Navigator.of(context).pop(a.result),
              ))
          .toList(),
    );
  }
}
