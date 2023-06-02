// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

class ImageNames {
  static const delete = 'delete';
  static const done = 'done';
  static const import = 'import';
  static const loading = 'loading';
  static const networkError = 'network_error';
  static const noInfo = 'no_info';
  static const ok = 'ok';
  static const overdue = 'overdue';
  static const privacy = 'privacy';
  static const purchase = 'purchase';
  static const risk = 'risk';
  static const save = 'save';
  static const serverError = 'server_error';
  static const start = 'start';
  static const sync = 'sync';
  static const transfer = 'transfer';
}

class MTImage extends StatelessWidget {
  const MTImage(this.name, {this.size});
  final String name;
  final double? size;

  bool get _dark => WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
  String _assetPath(String name) => 'assets/images/$name${_dark ? '_dark' : ''}.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _assetPath(name),
      width: size,
      height: size,
      errorBuilder: (_, __, ___) => Image.asset(
        _assetPath('no_info'),
        width: size,
        height: size,
      ),
    );
  }
}
