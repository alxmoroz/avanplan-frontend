// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

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
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';
import 'tariff_info.dart';

Future<Tariff?> tariffSelectDialog(List<Tariff> tariffs, int currentIndex, int selectedIndex, Workspace ws) async {
  return await showModalBottomSheet<Tariff?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TariffSelectView(tariffs, currentIndex, selectedIndex, ws)),
  );
}

class TariffSelectView extends StatelessWidget {
  const TariffSelectView(this.tariffs, this.currentIndex, this.selectedIndex, this.ws);
  final List<Tariff> tariffs;
  final int currentIndex;
  final int selectedIndex;
  final Workspace ws;

  Widget _selectButton(BuildContext context, Tariff tariff) => MTButton.outlined(
        titleColor: greenColor,
        titleText: loc.tariff_select_action_title,
        margin: const EdgeInsets.all(P).copyWith(top: 0),
        onTap: () => Navigator.of(context).pop(tariff),
      );

  Widget _paymentButton(BuildContext context, num balanceLack) {
    const snap = 1000;
    final whole = balanceLack % snap == 0;
    final paymentSum = ((balanceLack ~/ snap) + (whole ? 0 : 1)) * snap;
    return Padding(
        padding: const EdgeInsets.all(P).copyWith(top: 0),
        child: Column(children: [
          NormalText(
            'Для смены тарифа на балансе должно быть минимум ${balanceLack.currency} ₽',
            color: warningColor,
            align: TextAlign.center,
          ),
          const SizedBox(height: P_2),
          MTButton.outlined(
            titleText: '+ ${paymentSum.currency}',
            titleColor: greenColor,
            onTap: () => paymentController.ymQuickPayForm(paymentSum, ws.id!),
            constrained: false,
            padding: const EdgeInsets.symmetric(horizontal: P2),
          ),
        ]));
  }

  Widget _tariffCard(BuildContext context, int index) {
    final tariff = tariffs.elementAt(index);
    final balanceLack = tariff.estimateChargePerBillingPeriod - ws.balance;
    return MTCard(
      elevation: 3,
      child: Column(
        children: [
          const SizedBox(height: P),
          Expanded(child: TariffInfo(tariff)),
          currentIndex != index
              ? balanceLack <= 0
                  ? _selectButton(context, tariff)
                  : _paymentButton(context, balanceLack)
              : H3(loc.tariff_current_title, padding: const EdgeInsets.only(bottom: P2), color: lightGreyColor)
        ],
      ),
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
    return MTPage(
      navBar: navBar(
        context,
        leading: MTCloseButton(),
        title: loc.tariff_list_title,
        bgColor: backgroundColor,
      ),
      body: SafeArea(child: _tariffPages),
    );
  }
}
