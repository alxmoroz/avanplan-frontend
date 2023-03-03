// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/components/mt_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/tariff_presenter.dart';
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

  Widget get _tariffs => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: P),
          MTListTile(
            middle: Column(children: [LightText(loc.tariff_title), H4(ws.tariff.title)]),
            subtitle: LightText(ws.tariff.description),
          ),
        ],
      );

  Widget _payButton(num amount) => MTButton.outlined(
        titleText: '+ $amount',
        onTap: () => controller.ymQuickPayForm(amount),
        constrained: false,
        padding: const EdgeInsets.symmetric(horizontal: P),
      );

  Widget get _billing => Column(
        children: [
          const SizedBox(height: P),
          LightText(loc.balance_amount_title),
          const SizedBox(height: P_2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              D1('${controller.balance}',
                  color: controller.balance < 0
                      ? dangerColor
                      : controller.balance > 100
                          ? greenColor
                          : greyColor),
              const SizedBox(width: P_3),
              const H3('₽', color: lightGreyColor)
            ],
          ),
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
          H4(loc.member_list_title, padding: const EdgeInsets.symmetric(horizontal: P)),
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
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header,
              // TODO: ВКЛАДКИ?
              _tariffs,
              _billing,
              _users,
            ],
          ),
        ),
      ),
    );
  }
}
