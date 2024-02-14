// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff.dart';
import '../../presenters/workspace.dart';

Future showWSExpenses(Workspace ws) async => await showMTDialog<void>(_WSExpensesDialog(ws));

class _WSExpensesDialog extends StatelessWidget {
  const _WSExpensesDialog(this._ws);
  final Workspace _ws;

  Invoice get _invoice => _ws.invoice;
  Tariff get _tariff => _invoice.tariff;

  num get _chargeUsers => _invoice.expensesPerMonth(TOCode.USERS_COUNT);
  num get _overdraftUsers => _invoice.overdraft(TOCode.USERS_COUNT);
  num get _priceUsers => _tariff.price(TOCode.USERS_COUNT);

  num get _chargeTasks => _invoice.expensesPerMonth(TOCode.TASKS_COUNT);
  num get _overdraftTasks => _invoice.overdraft(TOCode.TASKS_COUNT);
  num get _priceTasks => _tariff.price(TOCode.TASKS_COUNT);
  String get _tasksQuantitySuffix => _tariff.billingQuantity(TOCode.TASKS_COUNT).humanSuffix;

  num get _chargeFSVolume => _invoice.expensesPerMonth(TOCode.FS_VOLUME);
  num get _overdraftFSVolume => _invoice.overdraft(TOCode.FS_VOLUME);
  num get _priceFSVolume => _tariff.price(TOCode.FS_VOLUME);
  String get _fsQuantitySuffix => _tariff.billingQuantity(TOCode.FS_VOLUME).humanBytesSuffix;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        color: b2Color,
        showCloseButton: true,
        middle: _ws.subPageTitle('${loc.workspace_expenses} ${loc.per_month_suffix}'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTListTile(
            middle: Row(children: [BaseText.f2(loc.tariff_title, maxLines: 1), BaseText(' ${_tariff.title}', maxLines: 1)]),
            trailing: MTPrice(_tariff.basePrice, size: AdaptiveSize.xs),
            bottomDivider: false,
          ),
          MTListSection(titleText: loc.tariff_additional_options_title),
          if (_chargeUsers > 0)
            MTListTile(
              titleText: loc.members_title,
              subtitle: D5('+$_overdraftUsers x ${_priceUsers.currency}₽', color: f2Color, align: TextAlign.left),
              trailing: MTPrice(_chargeUsers, size: AdaptiveSize.xs),
              bottomDivider: false,
            ),
          if (_chargeTasks > 0)
            MTListTile(
              titleText: loc.task_list_title,
              subtitle: D5('+$_overdraftTasks $_tasksQuantitySuffix x ${_priceTasks.currency}₽', color: f2Color, align: TextAlign.left),
              trailing: MTPrice(_chargeTasks, size: AdaptiveSize.xs),
              bottomDivider: false,
            ),
          if (_chargeFSVolume > 0)
            MTListTile(
              titleText: loc.file_storage_title,
              subtitle: D5('+$_overdraftFSVolume $_fsQuantitySuffix x ${_priceFSVolume.currency}₽', color: f2Color, align: TextAlign.left),
              trailing: MTPrice(_chargeFSVolume, size: AdaptiveSize.xs),
              bottomDivider: false,
            ),
          MTListTile(
            middle: BaseText.medium(loc.total_title),
            trailing: MTPrice(_invoice.overallExpensesPerMonth, size: AdaptiveSize.s, color: mainColor),
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
      ),
    );
  }
}
