// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';

class _TariffOption extends StatelessWidget {
  const _TariffOption(this._tariff, this._code);

  final Tariff _tariff;
  final String _code;

  static const iconSize = P7;
  static const fsTeamCode = TOCode.FEATURE_SET_TEAM;

  @override
  Widget build(BuildContext context) {
    num freeLimit = _tariff.freeLimit(_code);
    num quantity = _tariff.billingQuantity(_code);
    num price = _tariff.price(_code);

    String unit = '';
    String suffix = '';
    String extraQuantityStr = '';

    Widget icon = const SizedBox(height: iconSize);
    if (_code == TOCode.FS_VOLUME) {
      icon = const FileStorageIcon(size: iconSize);
      suffix = '${freeLimit.humanBytesSuffix} ';
      extraQuantityStr = '+${quantity.humanBytesStr}';
      unit = loc.tariff_option_fs_volume_suffix;
    } else {
      extraQuantityStr = '+${quantity.humanValueStr}';
      if (_code == TOCode.USERS_COUNT) {
        icon = const PeopleIcon(size: iconSize);
        if (_tariff.hasOption(fsTeamCode)) {
          freeLimit = 1;
          price = _tariff.price(fsTeamCode);
          extraQuantityStr = loc.tariff_unlimited_value_title;
        }
        unit = loc.member_plural(freeLimit);
      } else if (_code == TOCode.TASKS_COUNT) {
        icon = const TasksIcon(size: iconSize);
        suffix = '${freeLimit.humanSuffix} ';
        unit = loc.task_plural(freeLimit);
      }
    }

    final freeLimitHuman = (freeLimit / quantity).round();

    return MTListTile(
      leading: icon,
      middle: Row(
        children: [
          D3('$freeLimitHuman ', align: TextAlign.left),
          D4('$suffix$unit', padding: const EdgeInsets.only(top: P)),
        ],
      ),
      subtitle: Row(
        children: [
          D5('$extraQuantityStr ${loc.for_} ', color: f2Color, align: TextAlign.left),
          MTPrice(price, color: f2Color, size: AdaptiveSize.xxs),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: P3),
      bottomDivider: false,
    );
  }
}

class TariffOptions extends StatelessWidget {
  const TariffOptions(this._tariff, {super.key});
  final Tariff _tariff;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TariffOption(_tariff, TOCode.USERS_COUNT),
        const SizedBox(height: P3),
        _TariffOption(_tariff, TOCode.TASKS_COUNT),
        const SizedBox(height: P3),
        _TariffOption(_tariff, TOCode.FS_VOLUME),
        const SizedBox(height: P3),
        if (_tariff.hasManageableOptions)
          MTListTile(
            leading: const FeaturesIcon(size: _TariffOption.iconSize),
            middle: D4(loc.tariff_features_title, align: TextAlign.left),
            subtitle: Row(
              children: [
                D5('${loc.days_count(30)} ${loc.for_} ', color: f2Color, align: TextAlign.left),
                const MTPrice(0, color: f2Color, size: AdaptiveSize.xxs),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: P3),
            bottomDivider: false,
          ),
      ],
    );
  }
}
