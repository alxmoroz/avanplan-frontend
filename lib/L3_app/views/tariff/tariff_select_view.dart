// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/number.dart';
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
  int get selectedIndex => currentIndex < tariffs.length ? currentIndex + 1 : currentIndex;

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
                : H2(loc.tariff_current_title, color: f2Color),
            const SizedBox(height: P4),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: P2).copyWith(bottom: P2),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(
        middle: description.isNotEmpty
            ? H3(description, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3))
            : BaseText.medium(loc.tariff_list_title),
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
