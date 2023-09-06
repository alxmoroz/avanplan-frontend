// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/button.dart';
import '../../../../extra/services.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton(this._controller);
  final OnboardingController _controller;

  @override
  Widget build(BuildContext context) {
    return MTButton.main(
      titleText: _controller.lastStep ? loc.onboarding_finish_action_title : loc.onboarding_next_action_title,
      onTap: () => _controller.lastStep ? _controller.finish(context) : _controller.next(context),
    );
  }
}
