// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../main.dart';
import 'colors.dart';
import 'constants.dart';
import 'divider.dart';
import 'text.dart';

enum MTActionType {
  isDanger,
  isWarning,
  isDefault,
}

class MTADialogAction<T> {
  MTADialogAction({
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

Future<T?> showMTAlertDialog<T>(
  String title, {
  required List<MTADialogAction<T>> actions,
  String description = '',
  bool simple = false,
}) async {
  return await showCupertinoDialog<T?>(
    context: rootKey.currentContext!,
    barrierDismissible: true,
    builder: (_) => _MTAlertDialog(title: title, description: description, actions: actions, simple: simple),
  );
}

const _actionColors = {
  MTActionType.isDanger: dangerColor,
  MTActionType.isWarning: warningColor,
  MTActionType.isDefault: mainColor,
};

class _MTAlertDialog extends StatelessWidget {
  const _MTAlertDialog({
    required this.title,
    required this.actions,
    required this.description,
    required this.simple,
  });

  final String title;
  final List<MTADialogAction> actions;
  final String description;
  final bool simple;

  Widget _actionText(MTADialogAction a) => a.type == MTActionType.isDefault
      ? MediumText(a.title ?? '', color: _actionColors[a.type], align: TextAlign.center)
      : NormalText(a.title ?? '', color: _actionColors[a.type], align: TextAlign.center);

  Widget _actionRow(MTADialogAction a) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: a.child != null
          ? [a.child!]
          : [
              if (a.icon != null) ...[
                a.icon!,
                const SizedBox(width: P),
              ],
              Expanded(child: _actionText(a)),
            ]);

  @override
  Widget build(BuildContext context) {
    Future action(MTADialogAction a) async {
      if (a.onTap != null) {
        a.onTap!();
      }
      Navigator.of(context).pop(a.result);
    }

    Widget richButton(MTADialogAction a) => Column(
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
      title: H3(title, padding: const EdgeInsets.only(bottom: P), maxLines: 5),
      content: Column(
        children: [
          if (description.isNotEmpty) NormalText(description, maxLines: 12),
          if (!simple)
            for (final a in actions) richButton(a),
        ],
      ),
      actions: !simple ? [] : [for (final a in actions) CupertinoDialogAction(child: _actionText(a), onPressed: () => action(a))],
    );
  }
}
