// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class LSDateCode {
  static const APP_UPGRADE_PROPOSAL = 'APP_UPGRADE_PROPOSAL';
}

class LocalSettings extends LocalPersistable {
  LocalSettings({
    super.id = 'settings',
    this.launchCount = 0,
    this.version = '',
    this.flags,
    this.dates,
  });

  int launchCount;
  String version;
  Map<String, bool>? flags;
  Map<String, DateTime>? dates;

  bool getFlag(String code) => flags?[code] ?? false;
  void setFlag(String code, bool value) {
    flags ??= {};
    flags![code] = value;
  }

  DateTime? getDate(String code) => dates?[code];
  void setDate(String code, DateTime value) {
    dates ??= {};
    dates![code] = value;
  }

  void removeDate(String code) => dates?.remove(code);
}
