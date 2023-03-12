// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/invoice.dart';
import '../../components/colors.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'tariff_card.dart';
import 'tariff_view_controller.dart';

class TariffView extends StatefulWidget {
  const TariffView(this.invoice);
  final Invoice invoice;

  static String get routeName => '/tariff';
  @override
  State<TariffView> createState() => _TariffViewState();
}

class _TariffViewState extends State<TariffView> {
  late TariffViewController controller;

  Invoice get invoice => controller.invoice ?? widget.invoice;

  @override
  void initState() {
    controller = TariffViewController(widget.invoice);
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
          child: TariffCard(invoice.tariff),
        ),
        bottomBar: H1("КНОПКА ДЛЯ СМЕНЫ ТАРИФА"),
      ),
    );
  }
}
