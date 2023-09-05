// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/navbar.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingHeader {
  const OnboardingHeader(this._controller);
  final OnboardingController _controller;

  CupertinoNavigationBar build(BuildContext context) {
    return navBar(
      context,
      leading: MTButton(
        titleText: loc.onboarding_back_action_title,
        padding: const EdgeInsets.only(left: P2),
        onTap: () => Navigator.of(context).pop(),
      ),
      middle: _controller.onboarding ? H2('${_controller.stepIndex + 1} / ${_controller.stepsCount}', color: dangerColor) : null,
      trailing: _controller.stepIndex < _controller.stepsCount - 1
          ? MTButton(
              titleText: loc.onboarding_skip_action_title,
              padding: const EdgeInsets.only(right: P2),
              onTap: () => _controller.finish(context),
            )
          : null,
    );
  }
}
