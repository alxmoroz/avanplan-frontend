// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'tariff_info.dart';
import 'tariff_select_controller.dart';

Future<Tariff?> tariffSelectDialog(Workspace ws) async {
  return await showModalBottomSheet<Tariff?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TariffSelectView(ws)),
  );
}

class TariffSelectView extends StatefulWidget {
  const TariffSelectView(this.ws);
  final Workspace ws;

  @override
  _TariffSelectViewState createState() => _TariffSelectViewState();
}

class _TariffSelectViewState extends State<TariffSelectView> {
  Workspace get ws => widget.ws;

  late final TariffSelectController controller;

  @override
  void initState() {
    controller = TariffSelectController(ws.id!);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchData();
    });

    super.initState();
  }

  Widget tariffCard(int index) {
    final tariff = controller.tariffs.elementAt(index);
    return MTCard(
      elevation: 3,
      child: Column(children: [
        const SizedBox(height: P),
        Expanded(child: TariffInfo(tariff)),
        // TODO: условие отображения кнопки и её текста
        MTButton.outlined(
          titleText: 'ВЫБРАТЬ',
          margin: const EdgeInsets.all(P).copyWith(top: 0),
          onTap: () => Navigator.of(context).pop(tariff),
        )
      ]),
      margin: const EdgeInsets.symmetric(horizontal: P_2, vertical: P_2),
    );
  }

  Widget get tariffPages => PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: controller.tariffs.length,
        itemBuilder: (BuildContext context, int index) => tariffCard(index),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: MTCloseButton(),
          title: loc.tariff_list_title,
          bgColor: backgroundColor,
        ),
        body: SafeArea(child: tariffPages),
      ),
    );
  }
}
