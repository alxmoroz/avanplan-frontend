// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';

import 'colors_base.dart';
import 'constants.dart';
import 'dialog.dart';
import 'text.dart';

Future showMTNotification(String text) async {
  await showMTDialog(
    _MTNotificationDialog(text),
    forceBottomSheet: true,
    barrierColor: Colors.transparent,
  );
}

class _MTNotificationDialog extends StatefulWidget {
  const _MTNotificationDialog(this._text);
  final String _text;

  @override
  State<_MTNotificationDialog> createState() => _State();
}

class _State extends State<_MTNotificationDialog> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1000), () => Navigator.of(context).pop());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      bgColor: f1Color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(DEF_BORDER_RADIUS),
        topRight: Radius.circular(DEF_BORDER_RADIUS),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          H3(
            widget._text,
            color: b3Color,
            align: TextAlign.center,
            maxLines: 5,
            padding: const EdgeInsets.all(P3).copyWith(bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
          ),
        ],
      ),
    );
  }
}
