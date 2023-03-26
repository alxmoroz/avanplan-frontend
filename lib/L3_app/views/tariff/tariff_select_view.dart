// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';
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
import '../../components/mt_list_tile.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';
import '../../presenters/ws_presenter.dart';
import 'tariff_info.dart';

Future changeTariff(Workspace ws, {String reason = ''}) async {
  loaderController.start();
  loaderController.setRefreshing();
  final tariffs = (await tariffUC.getAll(ws.id!)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
  await loaderController.stop();
  if (tariffs.isNotEmpty) {
    final tariff = await tariffSelectDialog(tariffs, ws.id!, description: reason);
    if (tariff != null) {
      loaderController.start();
      loaderController.setSaving();
      final signedContractInvoice = await contractUC.sign(tariff.id!, ws.id!);
      if (signedContractInvoice != null) {
        ws.invoice = signedContractInvoice;
      }
      await loaderController.stop();
    }
  }
}

Future<Tariff?> tariffSelectDialog(List<Tariff> tariffs, int wsId, {String description = ''}) async {
  return await showModalBottomSheet<Tariff?>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TariffSelectView(tariffs, wsId, description: description)),
  );
}

class TariffSelectView extends StatelessWidget {
  const TariffSelectView(this.tariffs, this.wsId, {this.description = ''});
  final List<Tariff> tariffs;
  final String description;

  final int wsId;

  Workspace get ws => mainController.wsForId(wsId)!;
  int get currentIndex => tariffs.indexWhere((t) => t.id == ws.invoice.tariff.id);
  int get selectedIndex => currentIndex < tariffs.length - 1 ? currentIndex + 1 : currentIndex;

  Widget _selectButton(BuildContext context, Tariff tariff) => MTButton.outlined(
        titleColor: greenColor,
        titleText: loc.tariff_select_action_title,
        margin: const EdgeInsets.all(P).copyWith(top: 0),
        onTap: () => Navigator.of(context).pop(tariff),
      );

  Widget _paymentButton(BuildContext context, num balanceLack) {
    const snap = 100;
    const minSum = 300;
    const maxSum = 10000;
    final whole = balanceLack % snap == 0;
    final snappedSum = ((balanceLack ~/ snap) + (whole ? 0 : 1)) * snap;
    final paymentSum = min(maxSum, max(minSum, snappedSum));
    return Padding(
        padding: const EdgeInsets.all(P).copyWith(top: 0),
        child: Column(children: [
          NormalText(
            loc.error_tariff_insufficient_funds_for_change('${balanceLack.currency} ₽'),
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
      // navBar: navBar(
      //   context,
      //   leading: MTCloseButton(),
      //   middle: ws.subPageTitle(loc.tariff_list_title),
      //   bgColor: backgroundColor,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            MTListTile(
              leading: MTCloseButton(),
              middle: ws.subPageTitle(loc.tariff_list_title),
              padding: const EdgeInsets.symmetric(vertical: P_2),
              bottomBorder: false,
              trailing: const SizedBox(width: P2 * 2),
            ),
            if (description.isNotEmpty) H4(description, align: TextAlign.center, padding: const EdgeInsets.all(P).copyWith(top: P_2)),
            Expanded(child: _tariffPages),
          ],
        ),
      ),
    );
  }
}
