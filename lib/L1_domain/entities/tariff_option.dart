// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import 'base_entity.dart';
import 'promo_action.dart';

class TOCode {
  static const BASE_PRICE = 'BASE_PRICE';
  static const TASKS = 'TASKS';
  static const FILE_STORAGE = 'FILE_STORAGE';
  static const TEAM = 'TEAM';
  static const ANALYTICS = 'ANALYTICS';
  static const GOALS = 'GOALS';
  static const TASKBOARD = 'TASKBOARD';
}

class TariffOption extends Codable {
  TariffOption({
    required super.id,
    required super.code,
    required this.price,
    required this.tariffQuantity,
    required this.freeLimit,
    required this.userManageable,
    required this.projectRelated,
    required this.promoAction,
  });

  final num price;
  final num tariffQuantity;
  final num freeLimit;
  final bool userManageable;
  final bool projectRelated;
  final PromoAction? promoAction;

  String get title => Intl.message('tariff_option_${code.toLowerCase()}_title');
  String get subtitle => Intl.message('tariff_option_${code.toLowerCase()}_subtitle');
  String get description => Intl.message('tariff_option_${code.toLowerCase()}_description');

  num get _discount => promoAction?.discount ?? 0;
  num get finalPrice => price * (1 - _discount);
  bool get hasDiscount => _discount > 0;
}
