// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/tariff_presenter.dart';
import 'tariff_view_controller.dart';

class TariffView extends StatefulWidget {
  const TariffView(this.tariff);
  final Tariff tariff;

  static String get routeName => '/tariff';
  @override
  State<TariffView> createState() => _TariffViewState();
}

class _TariffViewState extends State<TariffView> {
  late TariffViewController controller;

  Tariff get tariff => controller.tariff ?? widget.tariff;

  @override
  void initState() {
    controller = TariffViewController(widget.tariff);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.tariff_title),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              H4(tariff.optionsDescription),
              H4(tariff.limitsDescription),
            ],
          ),
        ),
        bottomBar: H1("КНОПКА ДЛЯ СМЕНЫ ТАРИФА"),
      ),
    );
  }
}
