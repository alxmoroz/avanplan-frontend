// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff_option.dart';
import '../../components/adaptive.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../components/text.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff_option.dart';
import '../app/services.dart';

class TariffOptionTile extends StatelessWidget {
  const TariffOptionTile(this._to, {super.key});
  final TariffOption _to;

  @override
  Widget build(BuildContext context) {
    String unit = '';
    String suffix = '';
    String extraQuantityStr = '';

    // TODO: deprecated USERS_COUNT, FS_VOLUME как только не останется старых тарифов
    if ([TOCode.FILE_STORAGE, 'FS_VOLUME'].contains(_to.code)) {
      suffix = '${_to.freeLimit.humanBytesSuffix} ';
      extraQuantityStr = '+${_to.tariffQuantity.humanBytesStr}';
      unit = loc.tariff_option_file_storage_suffix;
    } else {
      extraQuantityStr = '+${_to.tariffQuantity.humanValueStr}';
      if ([TOCode.TEAM, 'USERS_COUNT'].contains(_to.code)) {
        unit = loc.member_plural(_to.freeLimit);
      }
      // TODO: deprecated TASKS_COUNT, как только не останется старых тарифов
      else if (_to.code.startsWith(TOCode.TASKS)) {
        suffix = '${_to.freeLimit.humanSuffix} ';
        unit = loc.task_plural(_to.freeLimit);
      }
    }

    final freeLimitHuman = '${(_to.freeLimit / _to.tariffQuantity).round()} ';

    return MTListTile(
      leading: _to.icon,
      middle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DText.medium(freeLimitHuman, align: TextAlign.left),
          BaseText('$suffix$unit', maxLines: 1),
        ],
      ),
      subtitle: Row(
        children: [
          DSmallText('$extraQuantityStr ${loc.for_} ', color: f2Color, align: TextAlign.left),
          MTPrice(_to.price, color: f2Color, size: AdaptiveSize.xs),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P4),
      bottomDivider: false,
    );
  }
}
