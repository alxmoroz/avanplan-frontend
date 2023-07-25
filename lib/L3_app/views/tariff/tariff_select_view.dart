// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_toolbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';
import '../../presenters/ws_presenter.dart';
import '../iap/iap_view.dart';
import 'request_tariff_card.dart';
import 'tariff_limits.dart';
import 'tariff_options.dart';

Future changeTariff(Workspace ws, {String reason = ''}) async {
  loader.start();
  loader.setLoading();
  final tariffs = (await tariffUC.getAll(ws)).sorted((t1, t2) => compareNatural('$t1', '$t2')).sorted((t1, t2) => t1.tier.compareTo(t2.tier));
  await loader.stop();
  if (tariffs.isNotEmpty) {
    final tariff = await showMTDialog<Tariff?>(TariffSelectView(tariffs, ws.id!, description: reason));
    if (tariff != null) {
      loader.start();
      loader.setSaving();
      final signedContractInvoice = await contractUC.sign(tariff.id!, ws.id!);
      if (signedContractInvoice != null) {
        // TODO: тут может менять не только тариф у РП, но и баланс. Нужно вытаскивать с бэка изменённое РП и дергать обсервер
        ws.invoice = signedContractInvoice;
      }
      await loader.stop();
    }
  }
}

class TariffSelectView extends StatelessWidget {
  const TariffSelectView(this.tariffs, this.wsId, {this.description = ''});
  final List<Tariff> tariffs;
  final String description;
  final int wsId;

  Workspace get ws => mainController.wsForId(wsId);
  int get currentIndex => tariffs.indexWhere((t) => t.id == ws.invoice.tariff.id);
  int get selectedIndex => currentIndex < tariffs.length ? currentIndex + 1 : currentIndex;

  Widget _selectButton(BuildContext context, Tariff tariff) => MTButton.main(
        titleText: loc.tariff_select_action_title,
        margin: const EdgeInsets.symmetric(horizontal: P),
        onTap: () => Navigator.of(context).pop(tariff),
      );

  Widget _paymentButton(BuildContext context, num balanceLack) {
    return Column(children: [
      NormalText(
        loc.error_tariff_insufficient_funds_for_change('${balanceLack.currency} ₽'),
        color: warningColor,
        align: TextAlign.center,
      ),
      MTButton.main(
        titleText: loc.balance_replenish_action_title,
        margin: const EdgeInsets.only(top: P_2),
        onTap: () => purchaseDialog(wsId),
      ),
    ]);
  }

  Widget _tariffCard(BuildContext context, int index) {
    if (index < tariffs.length) {
      final tariff = tariffs.elementAt(index);
      final balanceLack = tariff.estimateChargePerBillingPeriod - ws.balance;
      return MTCard(
        child: Column(
          children: [
            Expanded(child: TariffLimits(tariff)),
            TariffOptions(tariff),
            currentIndex != index
                ? balanceLack <= 0
                    ? _selectButton(context, tariff)
                    : _paymentButton(context, balanceLack)
                : H2(loc.tariff_current_title, color: lightGreyColor),
            const SizedBox(height: P2),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: P_2).copyWith(bottom: P_2),
      );
    } else {
      return RequestTariffCard();
    }
  }

  Widget _tariffPages(BuildContext context) {
    //TODO: сделать так же для доски задач (ширина) и для шторки (высота)!
    return LayoutBuilder(
      builder: (_, size) {
        final controller = PageController(
          viewportFraction: min(SCR_XS_WIDTH / size.maxWidth, 0.8),
          initialPage: selectedIndex,
        );
        return Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              controller: controller,
              itemCount: tariffs.length + 1,
              itemBuilder: _tariffCard,
            ),
            if (isWeb)
              Row(
                children: [
                  MTButton.icon(
                    const ChevronCircleIcon(left: true),
                    margin: const EdgeInsets.all(P),
                    onTap: () => controller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                  ),
                  const Spacer(),
                  MTButton.icon(
                    const ChevronCircleIcon(left: false),
                    margin: const EdgeInsets.all(P),
                    onTap: () => controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(
        middle: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ws.subPageTitle(loc.tariff_list_title),
            if (description.isNotEmpty) H3(description, align: TextAlign.center, padding: const EdgeInsets.all(P).copyWith(top: 0)),
          ],
        ),
      ),
      topBarHeight: description.isNotEmpty ? P * 6 : null,
      body: SafeArea(
        left: false,
        right: false,
        child: _tariffPages(context),
      ),
    );
  }
}
