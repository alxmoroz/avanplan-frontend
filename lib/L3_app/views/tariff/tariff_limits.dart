// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/components/colors_base.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/constants.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff.dart';

class _TariffLimitTile extends StatelessWidget {
  const _TariffLimitTile({
    required this.tariff,
    required this.code,
  });

  final Tariff tariff;
  final String code;

  static const iconSize = P5;

  @override
  Widget build(BuildContext context) {
    final value = tariff.limitValue(code);

    final String hvStr = value.humanValueStr;
    final plural = num.tryParse(hvStr) == null ? 10 : value;

    final prefix = loc.tariff_limit_up_to_prefix;
    String suffix = '';

    Widget icon = const SizedBox(width: iconSize);
    if (code == 'USERS_COUNT') {
      icon = const PeopleIcon(size: iconSize, color: f2Color);
      suffix = loc.user_plural_genitive(plural);
    } else if (code == 'PROJECTS_COUNT') {
      icon = const ProjectsIcon(size: iconSize, color: f2Color);
      suffix = loc.project_plural_genitive(plural);
    } else if (code == 'TASKS_COUNT') {
      icon = const TasksIcon(size: iconSize, color: f2Color);
      suffix = loc.task_plural_genitive(plural);
    }

    return MTListTile(
      leading: icon,
      middle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          NormalText.f2(prefix),
          const SizedBox(width: P),
          H3(hvStr),
          const SizedBox(width: P),
          NormalText(suffix),
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
    return ListView(
      children: [
        H3(tariff.title, align: TextAlign.center, padding: const EdgeInsets.all(P3)),
        for (var code in tariff.limitsMap.keys) _TariffLimitTile(tariff: tariff, code: code),
      ],
    );
  }
}
