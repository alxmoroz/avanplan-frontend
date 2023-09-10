// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

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
import '../../usecases/ws_actions.dart';
import '../../usecases/ws_sources.dart';
import '../iap/iap_view.dart';
import '../source/source_list_view.dart';
import '../tariff/active_contract_view.dart';
import '../user/user_list_view.dart';
import 'workspace_edit_view.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView(this._wsId);
  final int _wsId;

  static String get routeName => '/workspace';
  static String title(int wsId) => '${loc.workspace_title}: ${mainController.wsForId(wsId)}';

  Workspace get ws => mainController.wsForId(_wsId);

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: Column(
          children: [
            const SizedBox(height: P),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (ws.code.isNotEmpty) Flexible(child: H3('[${ws.code}] ', color: f3Color), flex: 1),
                Flexible(child: H2(ws.title, maxLines: 1), flex: 6),
              ],
            ),
            if (ws.description.isNotEmpty) BaseText(ws.description),
          ],
        ),
      );

  Widget get _balance => MTAdaptive.XS(
        child: MTCardButton(
          margin: const EdgeInsets.symmetric(vertical: P3),
          child: Column(
            children: [
              BaseText(loc.balance_amount_title, color: f2Color),
              const SizedBox(height: P2),
              MTCurrency(ws.balance, color: ws.balance < 0 ? warningColor : mainColor),
              const SizedBox(height: P2),
              if (ws.hpTariffUpdate) BaseText.medium(loc.balance_replenish_action_title, color: mainColor),
            ],
          ),
          onTap: ws.hpTariffUpdate ? () => purchaseDialog(_wsId) : null,
        ),
      );

  Widget get _tariff => MTListTile(
        leading: const TariffIcon(),
        middle: Row(children: [BaseText(loc.tariff_title), const SizedBox(width: P), BaseText.medium(ws.invoice.tariff.title)]),
        subtitle: SmallText('${loc.contract_effective_date_title} ${ws.invoice.contract.createdOn.strMedium}'),
        trailing: const ChevronIcon(),
        bottomDivider: false,
        onTap: () async => await Navigator.of(rootKey.currentContext!).pushNamed(ActiveContractView.routeName, arguments: ws),
      );

  Widget get _users => MTListTile(
      leading: const PeopleIcon(size: P6),
      titleText: '${loc.user_list_title} (${ws.users.length})',
      trailing: const ChevronIcon(),
      onTap: () async => await Navigator.of(rootKey.currentContext!).pushNamed(UserListView.routeName, arguments: ws));

  Widget get _sources => MTListTile(
      leading: const ImportIcon(),
      titleText: loc.source_list_title,
      trailing: const ChevronIcon(),
      bottomDivider: false,
      onTap: () async {
        ws.checkSources();
        await Navigator.of(rootKey.currentContext!).pushNamed(SourceListView.routeName, arguments: ws.id);
      });

  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: appBar(context,
          title: loc.workspace_title,
          trailing: ws.hpInfoUpdate
              ? MTButton.icon(
                  const EditIcon(),
                  onTap: () => editWSDialog(ws),
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
            _users,
            if (ws.hpSourceCreate) _sources,
          ],
        ),
      ),
    );
  }
}
