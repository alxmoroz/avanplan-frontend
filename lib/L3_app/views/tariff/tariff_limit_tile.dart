// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_list_tile.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';

class TariffLimitTile extends StatelessWidget {
  const TariffLimitTile({
    super.key,
    required this.tariff,
    required this.code,
  });

  final Tariff tariff;
  final String code;

  @override
  Widget build(BuildContext context) {
    final value = tariff.limitValue(code);

    String hvStr = value.hvStr;
    final plural = num.tryParse(hvStr) == null ? 10 : value;

    String prefix = loc.tariff_limit_up_to_prefix;
    String suffix = '';

    Widget icon = const SizedBox(width: P2);
    if (code == 'USERS_COUNT') {
      icon = const PeopleIcon();
      suffix = loc.user_plural_genitive(plural);
    } else if (code == 'PROJECTS_COUNT') {
      icon = const ProjectsIcon();
      suffix = loc.project_plural_genitive(plural);
    } else if (code == 'TASKS_COUNT') {
      icon = const TasksIcon();
      suffix = loc.task_plural_genitive(plural);
    } else if (code == 'PROJECTS_UNLINK_ALLOWED') {
      icon = const ImportIcon(color: greyColor, size: P2);
      hvStr = '';
      prefix = Intl.message('tariff_limit_projects_unlink_allowed_$value');
    } else if (code == 'BILLING_PERIOD_DAYS') {
      icon = const BillingPeriodIcon();
      prefix = loc.tariff_limit_billing_period_title;
      suffix = loc.days_count(value);
    }

    return MTListTile(leading: icon, titleText: '$prefix$hvStr $suffix', bottomBorder: false);
  }
}
