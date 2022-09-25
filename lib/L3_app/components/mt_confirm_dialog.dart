// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_button.dart';
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
      ? MediumText(a.title ?? '', color: _actionColors[a.type])
      : NormalText(a.title ?? '', color: _actionColors[a.type]);

  Widget _actionRow(MTDialogAction a) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: a.child != null
          ? [a.child!]
          : [
              if (a.icon != null) ...[
                a.icon!,
                SizedBox(width: onePadding / 3),
              ],
              _actionText(a),
            ]);

  @override
  Widget build(BuildContext context) {
    Future action(MTDialogAction a) async {
      if (a.onTap != null) {
        a.onTap!();
      }
      Navigator.of(context).pop(a.result);
    }

    return CupertinoAlertDialog(
      title: H4(title, padding: EdgeInsets.only(bottom: onePadding), maxLines: 5, color: darkColor),
      content: Column(
        children: [
          if (description.isNotEmpty) NormalText(description),
          if (!simple)
          // TODO(san-smith): Есть мнение, что оператор распаковки плохо влияет на производительность из-за ленивости.
          // То же самое можно сделать через коллекционный for:
          // for (final a in actions) 
          //   MTButton(
          //     '',
          //     () => action(a),
          //     child: _actionRow(a),
          //     padding: EdgeInsets.only(top: onePadding * 2),
          //   ),
            ...actions
                .map((a) => MTButton(
                      '',
                      () => action(a),
                      child: _actionRow(a),
                      padding: EdgeInsets.only(top: onePadding * 2),
                    ))
                .toList(),
        ],
      ),
      actions: !simple ? [] : actions.map((a) => CupertinoDialogAction(child: _actionText(a), onPressed: () => action(a))).toList(),
    );
  }
}
