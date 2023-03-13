// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../tariff/tariff_info.dart';
import 'contract_view_controller.dart';

class ContractView extends StatefulWidget {
  const ContractView(this.ws);
  final Workspace ws;

  static String get routeName => '/tariff';
  @override
  State<ContractView> createState() => _ContractViewState();
}

class _ContractViewState extends State<ContractView> {
  late ContractViewController controller;

  Workspace get ws => widget.ws;

  @override
  void initState() {
    controller = ContractViewController(ws);
    super.initState();
  }

  @override
  void dispose() {
    controller.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MTPage(
      navBar: navBar(context, title: loc.tariff_current_title, bgColor: backgroundColor),
      body: SafeArea(
        // top: false,
        // bottom: false,
        child: TariffInfo(ws.invoice.tariff),
      ),
      bottomBar: MTButton.outlined(
        titleText: loc.tariff_change_action_title,
        onTap: () => controller.changeTariff(context, ws),
        margin: const EdgeInsets.symmetric(horizontal: P),
      ),
    );
  }
}
