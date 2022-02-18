// Copyright (c) 2022. Alexandr Moroz

import '../entities/base.dart';

class AppSettings extends BaseEntity {
  AppSettings({
    required this.firstLaunch,
    this.version = '',
    this.accessToken = '',
  }) : super(id: 'settings');

  final bool firstLaunch;
  String version;
  String accessToken;
}
