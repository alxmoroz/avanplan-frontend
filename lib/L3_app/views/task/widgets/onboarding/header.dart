// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/appbar.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../controllers/onboarding_controller.dart';

AppBar onboardingHeader(BuildContext context, OnboardingController _controller) {
  Widget stepMark(int index) {
    final isCurrent = _controller.stepIndex == index;
    final r1 = isCurrent ? P2 : P;
    final r2 = r1 - P_3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: P_3),
      child: CircleAvatar(
        radius: r1,
        backgroundColor: (isCurrent ? mainColor : f3Color).resolve(context),
        child: CircleAvatar(
          radius: r2,
          child: isCurrent ? D6('${_controller.stepIndex + 1}', color: mainColor) : null,
          backgroundColor: b2Color.resolve(context),
        ),
      ),
    );
  }

  return MTAppBar(
    context,
    leading: MTButton(
      titleText: loc.back_action_title,
      padding: const EdgeInsets.only(left: P2),
      onTap: () => _controller.back(context),
    ),
    middle: _controller.onboarding
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var index = 0; index < _controller.stepsCount; index++) stepMark(index),
            ],
          )
        : null,
    bottom: _controller.onboarding
        ? PreferredSize(
            child: BaseText.medium(
              _controller.stepTitle,
              padding: const EdgeInsets.only(bottom: P2),
            ),
            preferredSize: Size.fromHeight(const BaseText.medium('').style(context).fontSize ?? 0 + P2),
          )
        : null,
    trailing: _controller.stepIndex < _controller.stepsCount - 1
        ? MTButton(
            titleText: loc.skip_action_title,
            padding: const EdgeInsets.only(right: P2),
            onTap: () => _controller.finish(context),
          )
        : null,
  );
}
