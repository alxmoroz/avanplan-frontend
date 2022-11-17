// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_divider.dart';
import 'text_widgets.dart';

enum MTActionType {
  isDanger,
  isWarning,
  isDefault,
}

class MTDialogAction<T> {
  MTDialogAction({
    required this.result,
    this.title,
    this.child,
    this.icon,
    this.type,
    this.onTap,
  });

  final String? title;
  final T result;
  VoidCallback? onTap;
  final MTActionType? type;
  final Widget? icon;
  final Widget? child;
}

Future<T?> showMTDialog<T>(
  BuildContext context, {
  required String title,
  required List<MTDialogAction<T>> actions,
  String description = '',
  bool simple = false,
}) async {
  return await showCupertinoDialog<T?>(
    context: context,
    barrierDismissible: true,
    builder: (_) => MTConfirmDialog(title: title, description: description, actions: actions, simple: simple),
  );
}

const _actionColors = {
  MTActionType.isDanger: dangerColor,
  MTActionType.isWarning: warningColor,
  MTActionType.isDefault: mainColor,
};

class MTConfirmDialog extends StatelessWidget {
  const MTConfirmDialog({
    required this.title,
    required this.actions,
    required this.description,
    required this.simple,
  });

  final String title;
  final List<MTDialogAction> actions;
  final String description;
  final bool simple;

  Widget _actionText(MTDialogAction a) => a.type == MTActionType.isDefault
      ? MediumText(a.title ?? '', color: _actionColors[a.type], align: TextAlign.center)
      : NormalText(a.title ?? '', color: _actionColors[a.type], align: TextAlign.center);

  Widget _actionRow(MTDialogAction a) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: a.child != null
          ? [a.child!]
          : [
              if (a.icon != null) ...[
                a.icon!,
                const SizedBox(width: P_3),
              ],
              Expanded(child: _actionText(a)),
            ]);

  @override
  Widget build(BuildContext context) {
    Future action(MTDialogAction a) async {
      if (a.onTap != null) {
        a.onTap!();
      }
      Navigator.of(context).pop(a.result);
    }

    Widget richButton(MTDialogAction a) => Column(
          children: [
            const MTDivider(height: P2),
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: () => action(a),
              child: _actionRow(a),
            )
          ],
        );

    return CupertinoAlertDialog(
      title: H4(title, padding: const EdgeInsets.only(bottom: P), maxLines: 5, color: darkColor),
      content: Column(
        children: [
          if (description.isNotEmpty) NormalText(description),
          if (!simple)
            for (final a in actions) richButton(a),
        ],
      ),
      actions: !simple ? [] : [for (final a in actions) CupertinoDialogAction(child: _actionText(a), onPressed: () => action(a))],
    );
  }
}
