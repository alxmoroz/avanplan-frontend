// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class UACode {
  static const UPDATE_DETAILS_EXPLANATION_VIEWED = 'UPDATE_DETAILS_EXPLANATION_VIEWED';
  static const WELCOME_GIFT_INFO_VIEWED = 'WELCOME_GIFT_INFO_VIEWED';
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
