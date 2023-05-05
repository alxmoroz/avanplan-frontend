// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class LocalSettings extends LocalPersistable {
  LocalSettings({
    super.id = 'settings',
    this.launchCount = 0,
    this.version = '',
    this.flags,
  });

  int launchCount;
  String version;
  Map<String, bool>? flags;

  bool getFlag(String code) => flags?[code] ?? false;
  void setFlag(String code, bool value) {
    flags ??= {};
    flags![code] = value;
  }
}
