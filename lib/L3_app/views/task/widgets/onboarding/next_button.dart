// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../controllers/onboarding_controller.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton(this._controller, {this.margin});
  final OnboardingController _controller;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return MTButton.main(
      titleText: _controller.nextBtnTitle,
      margin: margin ?? const EdgeInsets.symmetric(vertical: P3),
      loading: _controller.project.loading,
      onTap: () => _controller.next(context),
    );
  }
}
