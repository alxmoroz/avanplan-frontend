// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/circular_progress.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'request_tariff_card.dart';
import 'tariff_card.dart';
import 'tariff_selector_controller.dart';

Future<Tariff?> selectTariff(int wsId, {String reason = ''}) async {
  final tsController = TariffSelectorController(wsId, reason);
  tsController.reload();
  return await showMTDialog<Tariff?>(
    _TariffSelectorDialog(tsController),
    maxWidth: SCR_XL_WIDTH,
  );
}

class _TariffSelectorDialog extends StatelessWidget {
  const _TariffSelectorDialog(this._controller);
  final TariffSelectorController _controller;

  Widget _tariffCard(BuildContext context, int index) {
    Widget? card;
    if (index < _controller.tariffs.length) {
      final tariff = _controller.tariffs.elementAt(index);
      card = TariffCard(tariff, _controller, index == _controller.activeTariffIndex);
    } else {
      card = const RequestTariffCard();
    }
    return card;
  }

  Widget _pageButton(PageController controller, BuildContext context, {required bool left}) {
    const ad = Duration(milliseconds: 400);
    final startColor = b2Color.resolve(context);
    final endColor = startColor.withAlpha(0);
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: left ? Alignment.centerLeft : Alignment.centerRight,
            end: left ? Alignment.centerRight : Alignment.centerLeft,
            colors: [startColor, endColor],
          ),
        ),
        child: _controller.showPageButton(left)
            ? MTButton.icon(
                ChevronCircleIcon(left: left),
                padding: EdgeInsets.only(left: left ? P2 : P6, right: left ? P6 : P2),
                onTap: () => left
                    ? controller.previousPage(duration: ad, curve: Curves.easeInOut)
                    : controller.nextPage(duration: ad, curve: Curves.easeInOut),
              )
            : null);
  }

  Widget _tariffPages(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: P * 94),
      child: _controller.loading
          ? const Center(child: MTCircularProgress(unbound: true))
          : LayoutBuilder(
              builder: (_, size) {
                final pageController = PageController(
                  viewportFraction: (SCR_XXS_WIDTH + P4) / size.maxWidth,
                  initialPage: _controller.suggestedTariffIndex,
                );
                return Observer(
                  builder: (_) => Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: pageController,
                        itemCount: _controller.pagesCount,
                        itemBuilder: _tariffCard,
                        onPageChanged: _controller.pageChanged,
                      ),
                      if (isWeb)
                        Row(
                          children: [
                            _pageButton(pageController, context, left: true),
                            const Spacer(),
                            _pageButton(pageController, context, left: false),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          innerHeight: _controller.reason.isNotEmpty ? P12 : P8,
          middle: BaseText.medium(
            _controller.reason.isNotEmpty ? _controller.reason : loc.tariff_list_title,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P6),
            maxLines: 2,
          ),
        ),
        body: SafeArea(
          left: false,
          right: false,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom == 0 ? P2 : 0),
            child: _tariffPages(context),
          ),
        ),
      ),
    );
  }
}
