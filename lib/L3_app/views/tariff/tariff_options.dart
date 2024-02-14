// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/adaptive.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';

class _TariffOption extends StatelessWidget {
  const _TariffOption(this._tariff, this._code);

  final Tariff _tariff;
  final String _code;

  static const iconSize = P6;
  static const iconColor = mainColor;

  num get _freeLimit => _tariff.freeLimit(_code);
  num get _quantity => _tariff.billingQuantity(_code);
  num get _price => _tariff.price(_code);
  int get _freeLimitHuman => (_freeLimit / _quantity).round();

  @override
  Widget build(BuildContext context) {
    final smallHeight = MediaQuery.sizeOf(context).height < SCR_XS_HEIGHT;

    String unit = '';
    String suffix = '';
    String quantityStr = '';

    Widget icon = const SizedBox(height: iconSize);
    if (_code == TOCode.FS_VOLUME) {
      icon = const FileStorageIcon(size: iconSize, color: iconColor);
      suffix = '${_freeLimit.humanBytesSuffix} ';
      quantityStr = _quantity.humanBytesStr;
      unit = loc.tariff_option_fs_volume_suffix;
    } else {
      quantityStr = _quantity.humanValueStr;
      if (_code == TOCode.USERS_COUNT) {
        icon = const PeopleIcon(size: iconSize, color: iconColor);
        unit = loc.member_plural(_freeLimit);
      } else if (_code == TOCode.TASKS_COUNT) {
        icon = const TasksIcon(size: iconSize, color: iconColor);
        suffix = '${_freeLimit.humanSuffix} ';
        unit = loc.task_plural(_freeLimit);
      }
    }

    return SizedBox(
      width: (SCR_XXS_WIDTH - P6) / 3,
      child: Column(
        children: [
          if (!smallHeight) ...[
            icon,
            const SizedBox(height: P2),
          ],
          D3('$_freeLimitHuman'),
          const SizedBox(height: P),
          SmallText('$suffix$unit', maxLines: 1),
          if (!smallHeight) ...[
            const SizedBox(height: P3),
            D4('+$quantityStr'),
            const SizedBox(height: P),
            MTPrice(_price, color: f3Color, size: AdaptiveSize.xs),
          ]
        ],
      ),
    );
  }
}

class TariffOptions extends StatelessWidget {
  const TariffOptions(this._tariff, {super.key});
  final Tariff _tariff;

  @override
  Widget build(BuildContext context) {
    final bs = BorderSide(color: b1Color.resolve(context));
    const br = Radius.circular(DEF_BORDER_RADIUS);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: P * 17),
          height: P11,
          decoration: BoxDecoration(
            border: Border(left: bs, right: bs, bottom: bs),
            borderRadius: const BorderRadius.only(bottomLeft: br, bottomRight: br),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: P2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TariffOption(_tariff, TOCode.USERS_COUNT),
              _TariffOption(_tariff, TOCode.TASKS_COUNT),
              _TariffOption(_tariff, TOCode.FS_VOLUME),
            ],
          ),
        ),
      ],
    );
  }
}
