// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/appbar.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../controllers/onboarding_controller.dart';

AppBar onboardingHeader(BuildContext context, OnboardingController _controller) {
  return appBar(
    context,
    leading: MTButton(
      titleText: loc.back_action_title,
      padding: const EdgeInsets.only(left: P2),
      onTap: () => Navigator.of(context).pop(),
    ),
    middle: _controller.onboarding ? SmallText('${_controller.stepIndex + 1} / ${_controller.stepsCount}', color: dangerColor) : null,
    bottom: PreferredSize(
      child: BaseText.medium(
        _controller.stepTitle,
        padding: const EdgeInsets.only(bottom: P2),
      ),
      preferredSize: Size.fromHeight(const BaseText.medium('').style(context).fontSize ?? 0 + P2),
    ),
    trailing: _controller.stepIndex < _controller.stepsCount - 1
        ? MTButton(
            titleText: loc.skip_action_title,
            padding: const EdgeInsets.only(right: P2),
            onTap: () => _controller.finish(context),
          )
        : null,
  );
}
