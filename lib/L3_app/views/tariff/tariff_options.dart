// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
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

  TariffOption? get _option => _tariff.optionsMap[_code];
  num get _freeLimit => _option?.freeLimit ?? 0;
  int get _freeLimitHuman => (_freeLimit / (_option?.tariffQuantity ?? 1)).round();

  @override
  Widget build(BuildContext context) {
    String unit = '';
    String suffix = '';

    Widget icon = const SizedBox(height: iconSize);
    if (_code == TOCode.FS_VOLUME) {
      icon = const FileStorageIcon(size: iconSize, color: iconColor);
      suffix = '${_freeLimit.humanBytesSuffix} ';
      unit = loc.tariff_option_fs_volume_suffix;
    } else {
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
      width: (SCR_XXS_WIDTH - P4) / 3,
      child: Column(
        children: [
          icon,
          const SizedBox(height: P2),
          D3('$_freeLimitHuman'),
          const SizedBox(height: P),
          SmallText('$suffix$unit', maxLines: 1),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TariffOption(_tariff, TOCode.USERS_COUNT),
        _TariffOption(_tariff, TOCode.TASKS_COUNT),
        _TariffOption(_tariff, TOCode.FS_VOLUME),
      ],
    );
  }
}
