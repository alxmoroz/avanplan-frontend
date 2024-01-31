// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';

class _TariffLimitTile extends StatelessWidget {
  const _TariffLimitTile(this.tariff, this.code);

  final Tariff tariff;
  final String code;

  static const iconSize = P6;
  static const iconColor = mainColor;

  @override
  Widget build(BuildContext context) {
    final value = tariff.freeLimit(code);

    String hvStr = '';
    String suffix = '';

    Widget? icon;
    if (code == TOCode.FS_VOLUME) {
      hvStr = value.humanBytesStr;
      icon = const FileStorageIcon(size: iconSize, color: iconColor);
      suffix = loc.tariff_option_fs_volume_suffix;
    } else {
      hvStr = value.round().humanValueStr;
      final plural = num.tryParse(hvStr) == null ? 10 : value;
      if (code == TOCode.USERS_COUNT) {
        icon = const PeopleIcon(size: iconSize, color: iconColor);
        suffix = loc.member_plural(plural);
      } else if (code == TOCode.TASKS_COUNT) {
        icon = const TasksIcon(size: iconSize, color: iconColor);
        suffix = loc.task_plural(plural);
      }
    }

    return MTListTile(
      leading: icon,
      middle: Row(
        children: [
          BaseText.medium(hvStr, maxLines: 1),
          const SizedBox(width: P),
          BaseText(suffix, maxLines: 1),
        ],
      ),
      bottomDivider: false,
    );
  }
}

class TariffLimits extends StatelessWidget {
  const TariffLimits(this.tariff, {super.key});
  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _TariffLimitTile(tariff, TOCode.USERS_COUNT),
        _TariffLimitTile(tariff, TOCode.TASKS_COUNT),
        _TariffLimitTile(tariff, TOCode.FS_VOLUME),
      ],
    );
  }
}
