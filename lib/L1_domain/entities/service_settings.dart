// Copyright (c) 2022. Alexandr Moroz

import '../entities/base_entity.dart';

class ServiceSettings extends RPersistable {
  ServiceSettings({
    required super.id,
    required this.frontendFlags,
  });

  final String frontendFlags;
}
