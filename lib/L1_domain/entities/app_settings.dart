// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class AppSettings extends LocalPersistable {
  AppSettings({
    required this.firstLaunch,
    this.version = '',
  }) : super(id: 'settings');

  final bool firstLaunch;
  String version;
}
