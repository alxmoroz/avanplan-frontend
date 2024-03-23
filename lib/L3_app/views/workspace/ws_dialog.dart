// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/bytes.dart';
import '../../presenters/date.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import '../../usecases/ws_sources.dart';
import '../../usecases/ws_tariff.dart';
import '../iap/iap_dialog.dart';
import '../source/sources_dialog.dart';
import 'ws_edit_dialog.dart';
import 'ws_expenses_dialog.dart';
import 'ws_users_dialog.dart';

class WSRouter extends MTRouter {
  static const _prefix = '/settings/workspaces';

  @override
  String path({Object? args}) => '$_prefix/${args as int}';

  int get _wsId => int.parse(rs!.uri.pathSegments.lastOrNull ?? '-1');

  @override
  bool get isDialog => true;

  @override
  RegExp get pathRe => RegExp('^$_prefix/\\d+\$');

  @override
  Widget get page => _WSDialog(_wsId);

  @override
  String get title => '${loc.workspace_title_short} ${wsMainController.ws(_wsId).code}';
}

class _WSDialog extends StatelessWidget {
  const _WSDialog(this._wsId);
  final int _wsId;

  Workspace get _ws => wsMainController.ws(_wsId);
  Invoice get _invoice => _ws.invoice;

  num get _expensesPerDay => _invoice.currentExpensesPerDay;
  num get _consumedTasks => _invoice.consumed(TOCode.TASKS_COUNT);
  num get _consumedFSVolume => _invoice.consumed(TOCode.FS_VOLUME);
  bool get _hasExpenses => _expensesPerDay > 0;
  num get _balanceDays => (_ws.balance / _expensesPerDay);

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(child: H2(_ws.title, maxLines: 1)),
                if (_ws.codeStr.isNotEmpty) H3(' ${_ws.codeStr}', color: f3Color, maxLines: 1),
              ],
            ),
            if (_ws.description.isNotEmpty)
              BaseText.f2(
                _ws.description,
                maxLines: 3,
                padding: const EdgeInsets.only(top: P),
                align: TextAlign.center,
              ),
          ],
        ),
      );

  Widget get _balanceCard => MTAdaptive.xxs(
        child: MTCardButton(
          margin: const EdgeInsets.only(top: P3),
          onTap: () => replenishBalanceDialog(_wsId),
          child: Column(
            children: [
              BaseText.f2(loc.balance_amount_title),
              const SizedBox(height: P2),
              MTPrice(_ws.balance, color: _ws.balance < 0 ? warningColor : mainColor),
              const SizedBox(height: P2),
              BaseText.medium(loc.balance_replenish_action_title, color: mainColor),
            ],
          ),
        ),
      );

  Widget get _tariffRow => MTListTile(
        leading: const StarIcon(),
        titleText: _invoice.tariff.title,
        subtitle: SmallText(
          '${loc.contract_effective_date_title.toLowerCase()} ${_invoice.contract.createdOn.strMedium}',
          maxLines: 1,
        ),
        trailing: const ChevronIcon(),
        bottomDivider: _hasExpenses,
        dividerIndent: P11,
        onTap: () async => await _ws.changeTariff(),
      );

  Widget _tariffExpenses(BuildContext context) => MTListTile(
        leading: const BankCardIcon(),
        middle: Row(
          children: [
            BaseText(loc.tariff_current_expenses_title, maxLines: 1),
            const Spacer(),
            MTPrice(_expensesPerDay, size: AdaptiveSize.xxs),
            const SizedBox(width: P_2),
            BaseText.f2(loc.per_day_suffix),
          ],
        ),
        subtitle: SmallText(
          '${loc.workspace_money_remaining_time_prefix} ${loc.days_count(_balanceDays.round())}',
          maxLines: 1,
        ),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () => showWSExpenses(_ws),
      );

  Widget _wsMembers(BuildContext context) => MTListTile(
        leading: const PeopleIcon(),
        middle: Row(
          children: [
            BaseText('${_ws.users.length}', maxLines: 1),
            BaseText.f2(' ${loc.member_plural(_ws.users.length)}', maxLines: 1),
          ],
        ),
        subtitle: Row(children: [
          Flexible(child: SmallText(_ws.membersStr, maxLines: 1)),
          if (_ws.membersCountMoreStr.isNotEmpty)
            SmallText(
              _ws.membersCountMoreStr,
              maxLines: 1,
              padding: const EdgeInsets.only(left: P),
            )
        ]),
        trailing: const ChevronIcon(),
        bottomDivider: _consumedTasks > 0 || _consumedFSVolume > 0 || _ws.hpSourceCreate,
        dividerIndent: P11,
        onTap: () async => await MTRouter.navigate(WSUsersRouter, context, args: _ws.id!),
      );

  Widget _tasks(BuildContext context) => MTListTile(
        leading: const TasksIcon(),
        middle: Row(
          children: [
            BaseText(_consumedTasks.humanValueStr, maxLines: 1),
            BaseText.f2(' ${loc.task_plural(_consumedTasks)}', maxLines: 1),
          ],
        ),
        trailing: const SizedBox(width: P3),
        dividerIndent: P11,
        bottomDivider: _consumedFSVolume > 0 || _ws.hpSourceCreate,
      );

  Widget _storage(BuildContext context) => MTListTile(
        leading: const FileStorageIcon(),
        middle: Row(
          children: [
            BaseText(_consumedFSVolume.humanBytesStr, maxLines: 1),
            BaseText.f2(' ${loc.tariff_option_fs_volume_suffix}', maxLines: 1),
          ],
        ),
        trailing: const SizedBox(width: P3),
        dividerIndent: P11,
        bottomDivider: _ws.hpSourceCreate,
      );

  Widget _sources(BuildContext context) => MTListTile(
      leading: const ImportIcon(),
      titleText: '${loc.source_list_title} ${_ws.sources.isNotEmpty ? '(${_ws.sources.length})' : ''}',
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () async {
        _ws.checkSources();
        await MTRouter.navigate(SourcesRouter, context, args: _ws.id!);
      });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTDialog(
        topBar: MTAppBar(
            showCloseButton: true,
            color: b2Color,
            title: loc.workspace_title,
            trailing: _ws.hpInfoUpdate
                ? MTButton.icon(
                    const EditIcon(),
                    onTap: () => editWS(_ws),
                    margin: const EdgeInsets.only(right: P2),
                  )
                : null),
        body: ListView(
          shrinkWrap: true,
          children: [
            _header,
            _balanceCard,
            _hasExpenses ? MTListGroupTitle(titleText: loc.tariff_title) : const SizedBox(height: P3),
            _tariffRow,
            if (_hasExpenses) _tariffExpenses(context),
            const SizedBox(height: P3),
            if (_ws.hpMemberRead) _wsMembers(context),
            _tasks(context),
            _storage(context),
            if (_ws.hpSourceCreate) _sources(context),
          ],
        ),
      );
    });
  }
}
