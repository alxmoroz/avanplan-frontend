// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../L1_domain/entities/tariff_option.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/images.dart';
import '../presenters/number.dart';
import '../theme/colors.dart';
import '../views/app/services.dart';

const FEATURE_IMAGE_SIZE = P8;

extension TariffOptionPresenter on TariffOption {
  Widget icon({Color color = mainColor, double size = DEF_TAPPABLE_ICON_SIZE}) {
    return code.startsWith(TOCode.TASKS)
        ? TasksIcon(color: color, size: size)
        : [TOCode.FILE_STORAGE, 'FS_VOLUME'].contains(code)
            ? FileStorageIcon(color: color, size: size)
            : [TOCode.TEAM, 'USERS_COUNT'].contains(code)
                ? PeopleIcon(color: color, size: size)
                : code == TOCode.ANALYTICS
                    ? AnalyticsIcon(color: color, size: size)
                    : code == TOCode.FINANCE
                        ? FinanceIcon(color: color, size: size)
                        : FeaturesIcon(color: color, size: size);
  }

  String get title => Intl.message('tariff_option_${code.toLowerCase()}_title');
  String get subtitle => Intl.message('tariff_option_${code.toLowerCase()}_subtitle');
  String get description => Intl.message('tariff_option_${code.toLowerCase()}_description');

  Widget get image => MTImage('fs_${code.toLowerCase()}', width: FEATURE_IMAGE_SIZE, height: FEATURE_IMAGE_SIZE);

  String get priceDurationSuffix =>
      promoAction?.durationDays != null ? loc.price_duration_suffix(loc.days_count(promoAction!.durationDays)) : loc.per_month_suffix;

  String get priceDurationPrefix => promoAction?.durationDays != null ? loc.price_duration_prefix(loc.days_count(promoAction!.durationDays)) : '';

  String get nextPriceLocalizedString => ', ${loc.next_price_prefix} ${price.currencyRouble} ${loc.per_month_suffix}';
}
