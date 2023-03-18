// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
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
import '../../usecases/ws_ext_sources.dart';
import '../contract/contract_view.dart';
import '../source/source_list_view.dart';
import '../user/user_list_view.dart';

class WorkspaceView extends StatelessWidget {
  static String get routeName => '/workspace';

  Workspace get ws => mainController.selectedWS!;
  num get balance => ws.balance;

  Widget get _header => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P_2),
        child: Column(
          children: [
            const SizedBox(height: P_2),
            H3(ws.title, align: TextAlign.center),
            if (ws.description.isNotEmpty) NormalText(ws.description),
          ],
        ),
      );

  Widget _tariff(BuildContext context) => MTListTile(
        leading: Column(children: const [TariffIcon(), SmallText('')]),
        middle: Row(children: [NormalText(loc.tariff_title), const SizedBox(width: P_2), MediumText(ws.invoice.tariff.title)]),
        subtitle: SmallText('${loc.contract_effective_date_title} ${ws.invoice.contract.createdOn.strMedium}', color: greyColor),
        // TODO: if (controller.balance > 0) SmallText('Хватит на 1 мес.', color: greyColor),
        trailing: const ChevronIcon(),
        onTap: () async => await Navigator.of(context).pushNamed(ContractView.routeName),
      );

  Widget _payButton(num amount) => MTButton.outlined(
        titleText: '+ $amount',
        titleColor: greenColor,
        onTap: () => paymentController.ymQuickPayForm(amount, ws.id!),
        constrained: false,
        padding: const EdgeInsets.symmetric(horizontal: P),
      );

  Color get _balanceColor => balance < 0 ? warningColor : greyColor;

  Widget get _balance => Column(
        children: [
          LightText(loc.balance_amount_title),
          const SizedBox(height: P_2),
          MTCurrency(balance, _balanceColor),
          const SizedBox(height: P_2),
          const SizedBox(height: P),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _payButton(10),
              const SizedBox(width: P_2),
              _payButton(1000),
              const SizedBox(width: P_2),
              _payButton(3000),
              const SizedBox(width: P_2),
              _payButton(5000),
            ],
          ),
        ],
      );

  Widget _users(BuildContext context) => MTListTile(
      leading: const PeopleIcon(),
      titleText: '${loc.user_list_title} (${ws.users.length})',
      trailing: const ChevronIcon(),
      onTap: () async => await Navigator.of(context).pushNamed(UserListView.routeName));

  Widget _sources(BuildContext context) => MTListTile(
      leading: const ImportIcon(color: greyColor),
      titleText: loc.source_list_title,
      trailing: const ChevronIcon(),
      onTap: () async {
        mainController.selectedWS?.checkSources();
        await Navigator.of(context).pushNamed(SourceListView.routeName);
      });

  @override
  Widget build(BuildContext context) {
    return MTPage(
      navBar: navBar(context, title: loc.workspace_title),
      body: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          children: [
            _header,
            const SizedBox(height: P),
            _balance,
            const SizedBox(height: P),
            _tariff(context),
            _users(context),
            _sources(context),
          ],
        ),
      ),
    );
  }
}
