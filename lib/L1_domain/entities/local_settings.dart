// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class LSDateCode {
  static const APP_UPGRADE_PROPOSAL = 'APP_UPGRADE_PROPOSAL';
}

class LSStringCode {
  static const INVITATION_TOKEN = 'INVITATION_TOKEN';
  static const REGISTRATION_TOKEN = 'REGISTRATION_TOKEN';
  // static const UTM_VALUES = 'UTM_VALUES';
}

class LocalSettings extends LocalPersistable {
  LocalSettings({
    super.id = 'settings',
    this.launchCount = 0,
    this.version = '',
    this.flags,
    this.dates,
    this.strings,
  });

  int launchCount;
  String version;
  Map<String, bool>? flags;
  Map<String, DateTime>? dates;
  Map<String, String>? strings;

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

  String? getString(String code) => strings?[code];
  void setString(String code, String value) {
    strings ??= {};
    strings![code] = value;
  }

  void removeString(String code) => strings?.remove(code);
}
