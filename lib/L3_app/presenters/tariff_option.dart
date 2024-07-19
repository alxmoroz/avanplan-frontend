// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/tariff_option.dart';
import '../../L1_domain/utils/dates.dart';
import '../components/icons.dart';
import '../components/images.dart';
import '../extra/services.dart';

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

  Widget get image => MTImage('fs_${code.toLowerCase()}', width: 50, height: 50);

  String priceTerm(DateTime? endDate) => endDate != null
      ? loc.promo_end_duration(loc.days_count(endDate.difference(now).inDays))
      : promoAction?.durationDays != null
          ? loc.promo_duration(loc.days_count(promoAction!.durationDays))
          : loc.per_month_suffix;
}
