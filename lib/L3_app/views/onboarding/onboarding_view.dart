// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../components/constants.dart';
import '../../components/images.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/route.dart';
import '../../extra/services.dart';
import '../promo/promo_features.dart';
import '../quiz/quiz_header.dart';
import '../quiz/quiz_next_button.dart';
import 'onboarding_controller.dart';

final onboardingRoute = MTRoute(
  path: '/onboarding',
  baseName: 'onboarding',
  noTransition: true,
  redirect: (_, state) => state.extra == null ? '/' : null,
  builder: (_, __) => _OnboardingView(OnboardingController()),
);

class _OnboardingView extends StatelessWidget {
  const _OnboardingView(this._controller);
  final OnboardingController _controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTPage(
        appBar: QuizHeader(_controller),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              if (_controller.stepIndex < 3) ...[
                MTImage(['done', 'milestone', 'devices_sync'][_controller.stepIndex]),
                H2(
                  Intl.message('onboarding_step_${_controller.stepIndex + 1}_title'),
                  align: TextAlign.center,
                  padding: const EdgeInsets.all(P6).copyWith(bottom: P3),
                ),
                BaseText(
                  Intl.message('onboarding_step_${_controller.stepIndex + 1}_text'),
                  align: TextAlign.center,
                  padding: const EdgeInsets.symmetric(horizontal: P6),
                ),
                const SizedBox(height: P3),
                QuizNextButton(_controller),
              ],
              if (_controller.stepIndex == 3)
                PromoFeatures(wsMainController.myWS, onNext: _controller.next)
              else if (_controller.stepIndex == 4)
                H2('ПОСЛЕДНИЙ ШАГ', align: TextAlign.center),
            ],
          ),
        ),
      );
    });
  }
}
