// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'tariff_info.dart';

Future<Tariff?> tariffSelectDialog(List<Tariff> tariffs, int currentIndex, int selectedIndex) async {
  return await showModalBottomSheet<Tariff?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TariffSelectView(tariffs, currentIndex, selectedIndex)),
  );
}

class TariffSelectView extends StatelessWidget {
  const TariffSelectView(this.tariffs, this.currentIndex, this.selectedIndex);
  final List<Tariff> tariffs;
  final int currentIndex;
  final int selectedIndex;

  Widget _tariffCard(BuildContext context, int index) {
    final tariff = tariffs.elementAt(index);
    return MTCard(
      elevation: 3,
      child: Column(children: [
        const SizedBox(height: P),
        Expanded(child: TariffInfo(tariff)),
        currentIndex != index
            ? MTButton.outlined(
                titleColor: greenColor,
                titleText: loc.tariff_select_action_title,
                margin: const EdgeInsets.all(P).copyWith(top: 0),
                onTap: () => Navigator.of(context).pop(tariff),
              )
            : H3(loc.tariff_current_title, padding: const EdgeInsets.only(bottom: P2), color: lightGreyColor)
      ]),
      margin: const EdgeInsets.symmetric(horizontal: P_2, vertical: P_2),
    );
  }

  Widget get _tariffPages => PageView.builder(
        controller: PageController(
          viewportFraction: 0.8,
          initialPage: selectedIndex,
        ),
        itemCount: tariffs.length,
        itemBuilder: _tariffCard,
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
        body: SafeArea(child: _tariffPages),
      ),
    );
  }
}
