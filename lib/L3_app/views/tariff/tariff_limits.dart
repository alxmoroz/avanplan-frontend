// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/components/colors_base.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/constants.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    final value = tariff.limitValue(code);

    final String hvStr = value.humanValueStr;
    final plural = num.tryParse(hvStr) == null ? 10 : value;

    final prefix = loc.tariff_limit_up_to_prefix;
    String suffix = '';

    Widget icon = const SizedBox(width: P2);
    if (code == 'USERS_COUNT') {
      icon = const PeopleIcon(color: f2Color);
      suffix = loc.user_plural_genitive(plural);
    } else if (code == 'PROJECTS_COUNT') {
      icon = const ProjectsIcon(color: f2Color);
      suffix = loc.project_plural_genitive(plural);
    } else if (code == 'TASKS_COUNT') {
      icon = const TasksIcon(color: f2Color);
      suffix = loc.task_plural_genitive(plural);
    }

    return MTListTile(
      leading: icon,
      middle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: P_2),
          LightText(prefix),
          const SizedBox(width: P_2),
          H3(hvStr),
          const SizedBox(width: P_2),
          NormalText(suffix),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
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
        H3(tariff.title, align: TextAlign.center, padding: const EdgeInsets.all(P)),
        for (var code in tariff.limitsMap.keys) _TariffLimitTile(tariff: tariff, code: code),
      ],
    );
  }
}
