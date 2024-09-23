// Copyright (c) 2024. Alexandr Moroz

import '../entities/abs_contact.dart';

final _emailRx = RegExp(r'^.+@.+\..+');
final _phoneRx = RegExp(r'^\+?\d{6,15}');

extension ContactParserExtension on AbstractContact {
  String get email => value.replaceFirst('mailto:', '');
  bool get mayBeEmail => value.startsWith('mailto:') || _emailRx.hasMatch(email);

  String get phoneNumber => value.replaceFirst('tel:', '').replaceAll(RegExp(r'[^+\d]'), '');
  bool get mayBePhone => value.startsWith('tel:') || _phoneRx.hasMatch(phoneNumber);

  bool get mayBeUrl => value.startsWith(RegExp(r'https?://'));

  bool get other => !(mayBeEmail || mayBePhone || mayBeUrl);
}
