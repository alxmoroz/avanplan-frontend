// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class UACode {
  // static const TARIFF_EXCESS_INFO_VIEWED = 'TARIFF_EXCESS_INFO_VIEWED';
}

class UActivity extends Codable {
  UActivity({
    required super.id,
    required super.code,
    required this.platform,
    required this.createdOn,
    required this.wsId,
  });
  final String platform;
  final DateTime createdOn;
  final int? wsId;
}
