// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_button.dart';
import '../../components/mt_currency.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/tariff_presenter.dart';
import '../../usecases/ws_ext_actions.dart';
import '../../usecases/ws_ext_sources.dart';
import '../contract/contract_view.dart';
import '../source/source_list_view.dart';
import '../user/user_list_view.dart';
import 'workspace_edit_view.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView(this.ws);
  final Workspace ws;
  static String get routeName => '/workspace';

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P_2),
        child: Column(
          children: [
            const SizedBox(height: P),
            H3(ws.title, align: TextAlign.center),
            const SizedBox(height: P_2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LightText('[${ws.code}] '),
                if (ws.description.isNotEmpty) NormalText(ws.description),
              ],
            ),
          ],
        ),
      );

  Widget get _tariff => MTListTile(
        padding: const EdgeInsets.all(P).copyWith(top: P2),
        leading: Column(children: const [TariffIcon(), SmallText('')]),
        middle: Row(children: [NormalText(loc.tariff_title), const SizedBox(width: P_2), MediumText(ws.invoice.tariff.title)]),
        subtitle: SmallText('${loc.contract_effective_date_title} ${ws.invoice.contract.createdOn.strMedium}', color: greyColor),
        trailing: const ChevronIcon(),
        onTap: () async => await Navigator.of(rootKey.currentContext!).pushNamed(ContractView.routeName, arguments: ws),
      );

  Widget _payButton(int amount) => paymentController.ymPayButton(ws.id!, amount);

  Color get _balanceColor => ws.balance < 0 ? warningColor : greyColor;

  Widget get _balance => Column(
        children: [
          const SizedBox(height: P),
          LightText(loc.balance_amount_title),
          const SizedBox(height: P_2),
          MTCurrency(ws.balance, _balanceColor),
          const SizedBox(height: P_2),
          if (ws.hpTariffUpdate) ...[
            const SizedBox(height: P),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _payButton(300),
                const SizedBox(width: P_2),
                _payButton(500),
                const SizedBox(width: P_2),
                _payButton(1000),
                const SizedBox(width: P_2),
                _payButton(5000),
              ],
            ),
          ],
        ],
      );

  Widget get _users => MTListTile(
      leading: const PeopleIcon(),
      titleText: '${loc.user_list_title} (${ws.users.length})',
      trailing: const ChevronIcon(),
      onTap: () async => await Navigator.of(rootKey.currentContext!).pushNamed(UserListView.routeName, arguments: ws));

  Widget get _sources => MTListTile(
      leading: const ImportIcon(color: greyColor),
      titleText: loc.source_list_title,
      trailing: const ChevronIcon(),
      onTap: () async {
        ws.checkSources();
        await Navigator.of(rootKey.currentContext!).pushNamed(SourceListView.routeName, arguments: ws.id);
      });

  @override
  Widget build(BuildContext context) {
    return MTPage(
      navBar: navBar(context,
          title: loc.workspace_title,
          trailing: ws.hpInfoUpdate
              ? MTButton.icon(
                  const EditIcon(),
                  () => editWSDialog(ws),
                  margin: const EdgeInsets.only(right: P),
                )
              : null),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          children: [
            _header,
            if (serviceSettingsController.passAppleCheat) ...[
              _balance,
              _tariff,
            ],
            _users,
            _sources,
          ],
        ),
      ),
    );
  }
}
