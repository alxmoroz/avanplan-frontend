// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/tariff.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/button.dart';
import '../../components/card.dart';
import '../../components/circular_progress.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/tariff.dart';
import '../../usecases/ws_actions.dart';
import 'request_tariff_card.dart';
import 'tariff_limits.dart';
import 'tariff_options.dart';
import 'tariff_selector_controller.dart';

class TariffSelector extends StatelessWidget {
  const TariffSelector(this._controller);
  final TariffSelectorController _controller;

  Widget _selectButton(BuildContext context, Tariff tariff) => MTButton.main(
        titleText: loc.tariff_select_action_title,
        margin: const EdgeInsets.symmetric(horizontal: P3),
        onTap: () => _controller.selectTariff(context, tariff),
      );

  Widget _tariffCard(BuildContext context, int index) {
    final smallHeight = MediaQuery.sizeOf(context).height < SCR_XS_HEIGHT;
    Widget? card;
    if (index < _controller.tariffs.length) {
      final tariff = _controller.tariffs.elementAt(index);
      card = MTCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            H2(tariff.title, align: TextAlign.center, padding: const EdgeInsets.all(P3)),
            if (smallHeight) const Spacer() else Expanded(child: TariffLimits(tariff)),
            TariffOptions(tariff),
            const SizedBox(height: P),
            _controller.activeTariffIndex != index
                ? _controller.ws.hpTariffUpdate
                    ? _selectButton(context, tariff)
                    : const MTButton.main(middle: PrivacyIcon(color: f2Color), margin: EdgeInsets.symmetric(horizontal: P3))
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
      constraints: const BoxConstraints(maxHeight: P * 90),
      child: _controller.loading
          ? const Center(child: MTCircularProgress(color: mainColor, unbound: true))
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
        topBar: MTToolBar(
          middle: BaseText.medium(
            _controller.reason.isNotEmpty ? _controller.reason : loc.tariff_list_title,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P6),
            maxLines: 2,
          ),
        ),
        topBarHeight: _controller.reason.isNotEmpty ? P12 : P8,
        body: SafeArea(
          top: true,
          left: false,
          right: false,
          child: _tariffPages(context),
        ),
      ),
    );
  }
}
