// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'button.dart';
import 'colors_base.dart';
import 'constants.dart';
import 'dialog.dart';
import 'images.dart';
import 'text.dart';
import 'toolbar.dart';

class MTDialogAction<T> {
  MTDialogAction({
    this.result,
    this.title,
    this.type = ButtonType.secondary,
    this.onTap,
  });

  final String? title;
  final T? result;
  VoidCallback? onTap;
  final ButtonType type;
}

Future<T?> showMTAlertDialog<T>(
  String title, {
  String description = '',
  String imageName = '',
  required List<MTDialogAction<T>> actions,
}) async {
  return await showMTDialog<T?>(
    _MTAlertDialog(
      title,
      description: description,
      imageName: imageName,
      actions: actions,
    ),
    maxWidth: SCR_XS_WIDTH,
  );
}

class _MTAlertDialog extends StatelessWidget {
  const _MTAlertDialog(
    this.title, {
    required this.description,
    required this.imageName,
    required this.actions,
  });

  final String title;
  final String description;
  final String imageName;
  final List<MTDialogAction> actions;

  void _tap(BuildContext context, MTDialogAction a) async {
    if (a.onTap != null) {
      a.onTap!();
    }
    Navigator.of(context).pop(a.result);
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: const MTAppBar(showCloseButton: true, color: b2Color),
      body: ListView(
        shrinkWrap: true,
        children: [
          if (imageName.isNotEmpty) MTImage(imageName),
          H2(title, padding: const EdgeInsets.all(P3), align: TextAlign.center),
          if (description.isNotEmpty)
            BaseText(description, maxLines: 20, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P6)),
          for (final a in actions)
            MTButton(
              titleText: a.title,
              type: a.type,
              margin: const EdgeInsets.only(top: P3),
              constrained: true,
              onTap: () => _tap(context, a),
            ),
          if (actions.isNotEmpty && MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
        ],
      ),
    );
  }
}
