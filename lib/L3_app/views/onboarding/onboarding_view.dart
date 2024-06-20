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

  Widget get _stepImage => MTImage(['done', 'milestone', 'devices_sync'][_controller.stepIndex] ?? '');

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
                _stepImage,
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
              ],
              if (_controller.stepIndex == 3)
                H2('РЕКЛАМА', align: TextAlign.center)
              else if (_controller.stepIndex == 4)
                H2('ПОСЛЕДНИЙ ШАГ', align: TextAlign.center),
              if (_controller.stepIndex < 4) QuizNextButton(_controller),
            ],
          ),
        ),
      );
    });
  }
}
