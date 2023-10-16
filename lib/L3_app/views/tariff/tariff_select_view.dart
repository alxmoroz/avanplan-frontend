// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';
import '../../presenters/tariff.dart';
import '../iap/iap_view.dart';
import 'request_tariff_card.dart';
import 'tariff_limits.dart';
import 'tariff_options.dart';

class TariffSelectView extends StatelessWidget {
  const TariffSelectView(this.tariffs, this.wsId, {this.description = ''});
  final List<Tariff> tariffs;
  final String description;
  final int wsId;

  Workspace get ws => wsMainController.wsForId(wsId);
  int get currentIndex => tariffs.indexWhere((t) => t.id == ws.invoice.tariff.id);
  int get selectedIndex => currentIndex < tariffs.length && description.isNotEmpty ? currentIndex + 1 : currentIndex;

  Widget _selectButton(BuildContext context, Tariff tariff) => MTButton.main(
        titleText: loc.tariff_select_action_title,
        margin: const EdgeInsets.symmetric(horizontal: P3),
        onTap: () => Navigator.of(context).pop(tariff),
      );

  Widget _paymentButton(BuildContext context, num balanceLack) {
    return Column(children: [
      BaseText(
        loc.error_tariff_insufficient_funds_for_change('${balanceLack.currency} ₽'),
        color: warningColor,
        align: TextAlign.center,
      ),
      MTButton.main(
        titleText: loc.balance_replenish_action_title,
        margin: const EdgeInsets.only(top: P),
        onTap: () => purchaseDialog(wsId),
      ),
    ]);
  }

  Widget _tariffCard(BuildContext context, int index) {
    final smallHeight = MediaQuery.sizeOf(context).height < SCR_XS_HEIGHT;
    Widget? card;
    if (index < tariffs.length) {
      final tariff = tariffs.elementAt(index);
      final balanceLack = tariff.estimateChargePerBillingPeriod - ws.balance;
      card = MTCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            H2(tariff.title, align: TextAlign.center, padding: const EdgeInsets.all(P3)),
            if (smallHeight) const Spacer() else Expanded(child: TariffLimits(tariff)),
            TariffOptions(tariff),
            currentIndex != index
                ? balanceLack <= 0
                    ? _selectButton(context, tariff)
                    : _paymentButton(context, balanceLack)
                : MTButton.main(
                    titleText: loc.tariff_current_title,
                    margin: const EdgeInsets.symmetric(horizontal: P3),
                  ),
            const SizedBox(height: P3),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: P2).copyWith(bottom: P2),
      );
    } else {
      card = RequestTariffCard();
    }

    return card;
  }

  Widget _tariffPages(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: P * 80),
      child: LayoutBuilder(
        //TODO: сделать так же для доски задач (ширина) и для шторки (высота)!
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
                      margin: const EdgeInsets.all(P2),
                      onTap: () => controller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                    ),
                    const Spacer(),
                    MTButton.icon(
                      const ChevronCircleIcon(left: false),
                      margin: const EdgeInsets.all(P2),
                      onTap: () => controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(
        middle: BaseText.medium(
          description.isNotEmpty ? description : loc.tariff_list_title,
          align: TextAlign.center,
          padding: const EdgeInsets.symmetric(horizontal: P6),
        ),
      ),
      topBarHeight: description.isNotEmpty ? P12 : P8,
      body: SafeArea(
        top: true,
        left: false,
        right: false,
        child: _tariffPages(context),
      ),
    );
  }
}
