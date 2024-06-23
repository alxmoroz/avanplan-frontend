// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';

class PromoAction extends Codable {
  PromoAction({
    required super.id,
    required super.code,
    required this.discount,
    required this.durationDays,
  });

  final num discount;
  final int durationDays;
}
