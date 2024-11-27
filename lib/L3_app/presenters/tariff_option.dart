// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/tariff_option.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/images.dart';
import '../extra/services.dart';
import '../presenters/number.dart';

const FEATURE_IMAGE_SIZE = P8;

extension TariffOptionPresenter on TariffOption {
  Widget get icon {
    return code.startsWith(TOCode.TASKS)
        ? const TasksIcon()
        : [TOCode.FILE_STORAGE, 'FS_VOLUME'].contains(code)
            ? const FileStorageIcon()
            : [TOCode.TEAM, 'USERS_COUNT'].contains(code)
                ? const PeopleIcon()
                : code == TOCode.ANALYTICS
                    ? const AnalyticsIcon()
                    : code == TOCode.FINANCE
                        ? const FinanceIcon()
                        : const FeaturesIcon();
  }

  Widget get image => MTImage('fs_${code.toLowerCase()}', width: FEATURE_IMAGE_SIZE, height: FEATURE_IMAGE_SIZE);

  String get priceDurationSuffix =>
      promoAction?.durationDays != null ? loc.price_duration_suffix(loc.days_count(promoAction!.durationDays)) : loc.per_month_suffix;

  String get priceDurationPrefix => promoAction?.durationDays != null ? loc.price_duration_prefix(loc.days_count(promoAction!.durationDays)) : '';

  String get nextPriceLocalizedString => ', ${loc.next_price_prefix} ${price.currencyRouble} ${loc.per_month_suffix}';
}
