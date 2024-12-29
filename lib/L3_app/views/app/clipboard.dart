// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/snackbar_dialog.dart';
import 'services.dart';

Future copyToClipboard(BuildContext context, String text) async {
  Clipboard.setData(ClipboardData(text: text));
  await showMTSnackbar(loc.copied_to_clipboard_notification_title);
}
