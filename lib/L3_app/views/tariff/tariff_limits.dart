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
import '../../presenters/number.dart';

class _TariffLimitTile extends StatelessWidget {
  const _TariffLimitTile({
    required this.tariff,
    required this.code,
  });

  final Tariff tariff;
  final String code;

  static const iconSize = P6;

  @override
  Widget build(BuildContext context) {
    final value = tariff.limitValue(code);

    final String hvStr = value.humanValueStr;
    final plural = num.tryParse(hvStr) == null ? 10 : value;

    String suffix = '';
    const iconColor = mainColor;

    Widget icon = const SizedBox(width: iconSize);
    if (code == 'USERS_COUNT') {
      icon = const PeopleIcon(size: iconSize, color: iconColor);
      suffix = loc.member_plural(plural);
    } else if (code == 'PROJECTS_COUNT') {
      icon = const ProjectsIcon(size: iconSize, color: iconColor);
      suffix = loc.project_plural(plural);
    } else if (code == 'TASKS_COUNT') {
      icon = const TasksIcon(size: iconSize, color: iconColor);
      suffix = loc.task_plural(plural);
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
  const TariffLimits(this.tariff);
  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (_, index) => _TariffLimitTile(tariff: tariff, code: tariff.limitsMap.keys.elementAt(index)),
      itemCount: tariff.limitsMap.keys.length,
    );
  }
}
