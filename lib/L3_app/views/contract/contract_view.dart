// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'contract_view_controller.dart';
import 'tariff_info.dart';

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
    controller = ContractViewController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.tariff_title, bgColor: backgroundColor),
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
      ),
    );
  }
}
