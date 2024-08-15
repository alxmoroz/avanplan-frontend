// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/task.dart';
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
import 'where_we_go_step.dart';

final onboardingRoute = MTRoute(
  path: '/onboarding',
  baseName: 'onboarding',
  noTransition: true,
  redirect: (_, state) => state.extra == null ? '/' : null,
  builder: (_, state) => _OnboardingView(state.extra is TaskDescriptor ? state.extra as TaskDescriptor : null),
);

class _OnboardingView extends StatefulWidget {
  const _OnboardingView(this._hostProject);
  final TaskDescriptor? _hostProject;

  @override
  State<StatefulWidget> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  late final OnboardingController _controller;

  @override
  void initState() {
    _controller = OnboardingController(hostProjectIn: widget._hostProject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTPage(
        topBar: QuizHeader(_controller),
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
                  maxLines: 2,
                ),
                const SizedBox(height: P3),
                QuizNextButton(_controller),
              ],
              if (_controller.isPromoFeaturesStep)
                PromoFeatures(wsMainController.myWS, onLater: _controller.next)
              else if (_controller.isWhereWeGoStep)
                WhereWeGoStep(_controller),
            ],
          ),
        ),
      );
    });
  }
}
