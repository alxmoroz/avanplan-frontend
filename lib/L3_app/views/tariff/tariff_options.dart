// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/tariff_option.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/price.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff_option.dart';

class _TariffOption extends StatelessWidget {
  const _TariffOption(this._to);
  final TariffOption _to;

  @override
  Widget build(BuildContext context) {
    String unit = '';
    String suffix = '';
    String extraQuantityStr = '';

    // TODO: deprecated USERS_COUNT, FS_VOLUME как только не останется старых тарифов
    if ([TOCode.FILE_STORAGE, 'FS_VOLUME'].contains(_to.code)) {
      suffix = '${_to.freeLimit.humanBytesSuffix} ';
      extraQuantityStr = '+${_to.billingQuantity.humanBytesStr}';
      unit = loc.tariff_option_file_storage_suffix;
    } else {
      extraQuantityStr = '+${_to.billingQuantity.humanValueStr}';
      if ([TOCode.TEAM, 'USERS_COUNT'].contains(_to.code)) {
        unit = loc.member_plural(_to.freeLimit);
      }
      // TODO: deprecated TASKS_COUNT, как только не останется старых тарифов
      else if (_to.code.startsWith(TOCode.TASKS)) {
        suffix = '${_to.freeLimit.humanSuffix} ';
        unit = loc.task_plural(_to.freeLimit);
      }
    }

    final freeLimitHuman = '${(_to.freeLimit / _to.billingQuantity).round()} ';

    return MTListTile(
      leading: _to.icon,
      middle: Row(
        children: [
          D3.medium(freeLimitHuman, align: TextAlign.left),
          D3('$suffix$unit'),
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

class TariffOptions extends StatelessWidget {
  const TariffOptions(this._ws, this._tariff, {super.key});
  // NB! Тариф и РП совпадают в частном случае только. Поэтому отдельные аргументы
  final Workspace _ws;
  final Tariff _tariff;
  bool get _isMyTariff => _tariff.id == _ws.tariff.id;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => _TariffOption(_tariff.consumableOptions[index]),
          itemCount: _tariff.consumableOptions.length,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final f = _tariff.features[index];
            final actualPrice = (_isMyTariff ? _ws.finalPrice(f.code) : null) ?? f.finalPrice;
            final originalPrice = f.hasDiscount ? f.price : null;
            final term = f.priceTerm(_isMyTariff ? _ws.consumedEndDate(f.code) : null);
            return MTListTile(
              leading: f.icon,
              middle: D3(f.title, align: TextAlign.left),
              subtitle: Row(
                children: [
                  MTPrice(actualPrice, originalValue: originalPrice, color: f2Color, size: AdaptiveSize.xs),
                  DSmallText(' $term', color: f2Color, align: TextAlign.left),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P4),
              bottomDivider: false,
            );
          },
          itemCount: _tariff.features.length,
        ),
      ],
    );
  }
}
