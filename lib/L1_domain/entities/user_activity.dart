// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class UACode {
  static const ONBOARDING_PASSED = "ONB_PASSED";
  static const PROMO_FEATURES_VIEWED = "PROMO_FEATURES_VIEWED";
}

class UActivity extends Codable {
  UActivity({
    required super.id,
    required super.code,
    required super.createdOn,
    required this.platform,
    required this.wsId,
  });
  final String platform;
  final int? wsId;
}
