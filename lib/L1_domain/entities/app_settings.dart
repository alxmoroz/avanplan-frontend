// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class AppSettings extends RPersistable {
  AppSettings({
    required super.id,
    required this.frontendFlags,
  });

  final String frontendFlags;
}
