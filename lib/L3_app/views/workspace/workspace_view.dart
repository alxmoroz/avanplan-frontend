// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_button.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_money.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/tariff_presenter.dart';
import '../tariff/tariff_view.dart';
import 'workspace_view_controller.dart';

class WorkspaceView extends StatefulWidget {
  const WorkspaceView(this.ws);
  final Workspace ws;

  static String get routeName => '/workspace';
  @override
  State<WorkspaceView> createState() => _WorkspaceViewState();
}

class _WorkspaceViewState extends State<WorkspaceView> {
  late WorkspaceViewController controller;

  Workspace get ws => controller.ws ?? widget.ws;

  @override
  void initState() {
    controller = WorkspaceViewController(widget.ws);
    super.initState();
  }

  Future _showTariff(BuildContext context, Invoice invoice) async {
    await Navigator.of(context).pushNamed(TariffView.routeName, arguments: invoice);
  }

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

  Widget get _tariff => MTListTile(
        leading: Column(children: const [TariffIcon(), SmallText('')]),
        middle: Row(children: [NormalText(loc.tariff_title), const SizedBox(width: P_2), MediumText(ws.invoice.tariff.title)]),
        subtitle: SmallText('${loc.contract_effective_date_title} ${ws.invoice.contract.createdOn.strMedium}', color: greyColor),
        trailing: const ChevronIcon(),
        onTap: () => _showTariff(context, ws.invoice),
      );

  Widget _payButton(num amount) => MTButton.outlined(
        titleText: '+ $amount',
        onTap: () => paymentController.ymQuickPayForm(amount, controller.wsId),
        constrained: false,
        padding: const EdgeInsets.symmetric(horizontal: P),
      );

  Color get _balanceColor => controller.balance < 0
      ? dangerColor
      : controller.balance > 100
          ? greenColor
          : greyColor;

  Widget get _billing => Column(
        children: [
          LightText(loc.balance_amount_title),
          const SizedBox(height: P_2),
          MTCurrency(controller.balance, _balanceColor),
          const SizedBox(height: P_2),
          // TODO: if (controller.balance > 0) SmallText('Хватит на 1 мес.', color: greyColor),
          const SizedBox(height: P),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _payButton(10),
              const SizedBox(width: P_2),
              _payButton(100),
              const SizedBox(width: P_2),
              _payButton(500),
              const SizedBox(width: P_2),
              _payButton(2500),
              const SizedBox(width: P_2),
              _payButton(5000),
            ],
          ),
        ],
      );

  Widget get _users => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: P),
          NormalText(loc.member_list_title, padding: const EdgeInsets.symmetric(horizontal: P)),
          for (final user in ws.users)
            MTListTile(
              leading: user.icon(P2),
              titleText: '$user',
              subtitle: LightText(user.rolesStr),
            )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.workspace_title, bgColor: backgroundColor),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              _header,
              const SizedBox(height: P),
              _billing,
              const SizedBox(height: P),
              _tariff,
              _users,
            ],
          ),
        ),
      ),
    );
  }
}
