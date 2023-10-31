// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/adaptive.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/currency.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/date.dart';
import '../../presenters/tariff.dart';
import '../../presenters/workspace.dart';
import '../../usecases/ws_actions.dart';
import '../../usecases/ws_sources.dart';
import '../../usecases/ws_tariff.dart';
import '../iap/iap_view.dart';
import '../source/source_list_view.dart';
import '../user/user_list_view.dart';
import 'workspace_edit_view.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView(this._wsId);
  final int _wsId;

  static String get routeName => '/workspace';
  static String title(int wsId) => '${loc.workspace_title}: ${wsMainController.wsForId(wsId)}';

  Workspace get _ws => wsMainController.wsForId(_wsId);

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: Column(
          children: [
            const SizedBox(height: P),
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

  Widget get _balance => MTAdaptive.xxs(
        child: MTCardButton(
          margin: const EdgeInsets.symmetric(vertical: P3),
          child: Column(
            children: [
              BaseText.f2(loc.balance_amount_title),
              const SizedBox(height: P2),
              MTCurrency(_ws.balance, color: _ws.balance < 0 ? warningColor : mainColor),
              const SizedBox(height: P2),
              if (_ws.hpTariffUpdate) BaseText.medium(loc.balance_replenish_action_title, color: mainColor),
            ],
          ),
          onTap: _ws.hpTariffUpdate ? () => purchaseDialog(_wsId) : null,
        ),
      );

  Widget get _tariff => MTListTile(
        leading: const TariffIcon(),
        titleText: loc.tariff_title,
        subtitle: SmallText(
          '${_ws.invoice.tariff.title} (${loc.contract_effective_date_title.toLowerCase()} ${_ws.invoice.contract.createdOn.strMedium})',
          maxLines: 1,
        ),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () async => await _ws.changeTariff(),
      );

  Widget get _users => MTListTile(
        leading: const PeopleIcon(size: P6),
        titleText: loc.user_list_title,
        subtitle: SmallText('${_ws.users.length} / ${_ws.maxUsers}', maxLines: 1),
        trailing: const ChevronIcon(),
        onTap: () async => await Navigator.of(rootKey.currentContext!).pushNamed(UserListView.routeName, arguments: _ws.id),
      );

  Widget get _sources => MTListTile(
      leading: const ImportIcon(),
      titleText: '${loc.source_list_title} ${_ws.sources.isNotEmpty ? '(${_ws.sources.length})' : ''}',
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () async {
        _ws.checkSources();
        await Navigator.of(rootKey.currentContext!).pushNamed(SourceListView.routeName, arguments: _ws.id);
      });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(context,
            title: loc.workspace_title,
            trailing: _ws.hpInfoUpdate
                ? MTButton.icon(
                    const EditIcon(),
                    onTap: () => editWSDialog(_ws),
                    margin: const EdgeInsets.only(right: P2),
                  )
                : null),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              _header,
              _balance,
              _tariff,
              const SizedBox(height: P3),
              if (_ws.hpMemberRead) _users,
              if (_ws.hpSourceCreate) _sources,
            ],
          ),
        ),
      ),
    );
  }
}
