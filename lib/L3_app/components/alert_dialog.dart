// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../extra/router.dart';
import 'colors.dart';
import 'constants.dart';
import 'divider.dart';
import 'text.dart';

// TODO: переделать для использования нашего диалога

enum MTDialogActionType {
  danger,
  warning,
  isDefault,
}

class MTADialogAction<T> {
  MTADialogAction({
    required this.result,
    this.title,
    this.child,
    this.icon,
    this.type = MTDialogActionType.isDefault,
    this.onTap,
  });

  final String? title;
  final T result;
  VoidCallback? onTap;
  final MTDialogActionType? type;
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
    context: globalContext,
    barrierDismissible: true,
    builder: (_) => _MTAlertDialog(title: title, description: description, actions: actions, simple: simple),
  );
}

const _actionColors = {
  MTDialogActionType.danger: dangerColor,
  MTDialogActionType.warning: warningColor,
  MTDialogActionType.isDefault: mainColor,
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

  Widget _actionText(MTADialogAction a) => a.type == MTDialogActionType.isDefault
      ? BaseText.medium(a.title ?? '', color: _actionColors[a.type], align: TextAlign.center)
      : BaseText(a.title ?? '', color: _actionColors[a.type], align: TextAlign.center);

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

  void _action(BuildContext context, MTADialogAction a) async {
    if (a.onTap != null) {
      a.onTap!();
    }
    Navigator.of(context).pop(a.result);
  }

  Widget _button(BuildContext context, MTADialogAction a) => Column(
        children: [
          const MTDivider(verticalIndent: P),
          CupertinoButton(
            minSize: 0,
            padding: const EdgeInsets.symmetric(vertical: P, horizontal: P2),
            child: _actionRow(a),
            onPressed: () => _action(context, a),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: H3(title, padding: const EdgeInsets.only(bottom: P), maxLines: 5),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (description.isNotEmpty) BaseText(description, maxLines: 20),
          if (!simple)
            for (final a in actions) _button(context, a),
        ],
      ),
      actions: !simple ? [] : [for (final a in actions) CupertinoDialogAction(child: _actionText(a), onPressed: () => _action(context, a))],
    );
  }
}
