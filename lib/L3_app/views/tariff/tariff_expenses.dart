// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff.dart';

class TariffExpenses extends StatelessWidget {
  const TariffExpenses(this._tariff, this._invoice, {super.key});
  final Invoice _invoice;
  final Tariff _tariff;

  num get _teamExpenses => _invoice.expensesPerMonth(TOCode.TEAM, _tariff);
  num get _teamOverdraft => _invoice.overdraft(TOCode.TEAM, _tariff);
  num get _teamPrice => _tariff.price(TOCode.TEAM);

  num get _tasksExpenses => _invoice.expensesPerMonth(TOCode.TASKS, _tariff);
  num get _tasksOverdraft => _invoice.overdraft(TOCode.TASKS, _tariff);
  num get _tasksPrice => _tariff.price(TOCode.TASKS);
  String get _tasksQuantitySuffix => _tariff.billingQuantity(TOCode.TASKS).humanSuffix;

  num get _fsExpenses => _invoice.expensesPerMonth(TOCode.FILE_STORAGE, _tariff);
  num get _fsOverdraft => _invoice.overdraft(TOCode.FILE_STORAGE, _tariff);
  num get _fsPrice => _tariff.price(TOCode.FILE_STORAGE);
  String get _fsQuantitySuffix => _tariff.billingQuantity(TOCode.FILE_STORAGE).humanBytesSuffix;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        MTListTile(
          middle: Row(children: [BaseText.f2(loc.tariff_title, maxLines: 1), BaseText(' ${_tariff.title}', maxLines: 1)]),
          trailing: MTPrice(_tariff.basePrice, size: AdaptiveSize.s),
          bottomDivider: false,
        ),
        if (_teamExpenses > 0)
          MTListTile(
            titleText: loc.members_title,
            subtitle: DSmallText('+$_teamOverdraft x ${_teamPrice.currency}₽', color: f2Color, align: TextAlign.left),
            trailing: MTPrice(_teamExpenses, size: AdaptiveSize.s),
            bottomDivider: false,
          ),
        if (_tasksExpenses > 0)
          MTListTile(
            titleText: loc.task_list_title,
            subtitle: DSmallText('+$_tasksOverdraft $_tasksQuantitySuffix x ${_tasksPrice.currency}₽', color: f2Color, align: TextAlign.left),
            trailing: MTPrice(_tasksExpenses, size: AdaptiveSize.s),
            bottomDivider: false,
          ),
        if (_fsExpenses > 0)
          MTListTile(
            titleText: loc.file_storage_title,
            subtitle: DSmallText('+$_fsOverdraft $_fsQuantitySuffix x ${_fsPrice.currency}₽', color: f2Color, align: TextAlign.left),
            trailing: MTPrice(_fsExpenses, size: AdaptiveSize.s),
            bottomDivider: false,
          ),
        MTListTile(
          middle: BaseText.medium(loc.total_title),
          trailing: MTPrice(_invoice.overallExpensesPerMonth(_tariff), size: AdaptiveSize.m, color: mainColor),
          margin: const EdgeInsets.only(top: P3),
          bottomDivider: false,
        ),
        MTButton(
          middle: BaseText(loc.tariff_details_action_title, color: mainColor, maxLines: 1),
          margin: const EdgeInsets.only(top: P3),
          onTap: () => launchUrlString(_tariff.detailsUri),
        ),
        if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
      ],
    );
  }
}
