// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class LocalSettings extends LocalPersistable {
  LocalSettings({
    this.launchCount = 0,
    this.version = '',
    super.id = 'settings',
  });

  String version;
  int launchCount;
}
