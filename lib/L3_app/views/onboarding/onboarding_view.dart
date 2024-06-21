// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L3_app/components/button.dart';
import 'package:avanplan/L3_app/components/colors.dart';
import 'package:avanplan/L3_app/components/icons.dart';
import 'package:avanplan/L3_app/components/list_tile.dart';
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
import '../projects/create_project_controller.dart';
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

  Future _startWithProject() async {
    await _controller.next();
    CreateProjectController().startCreate();
  }

  Future _startWithTasks() async {
    await _controller.next();
  }

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
                PromoFeatures(wsMainController.myWS, onLater: _controller.next)
              else if (_controller.stepIndex == 4) ...[
                H2(
                  loc.onboarding_final_step_title,
                  align: TextAlign.center,
                  padding: const EdgeInsets.symmetric(horizontal: P6).copyWith(bottom: P2),
                ),
                MTCardButton(
                  margin: const EdgeInsets.symmetric(horizontal: P4, vertical: P2),
                  onTap: _startWithProject,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MTListTile(
                        leading: const ProjectsIcon(color: mainColor),
                        middle: H3(loc.onboarding_start_with_project_title),
                        trailing: const ChevronIcon(),
                        padding: EdgeInsets.zero,
                        bottomDivider: false,
                      ),
                      const SizedBox(height: P2),
                      BaseText(loc.onboarding_start_with_project_text, align: TextAlign.left, maxLines: 3),
                    ],
                  ),
                ),
                MTCardButton(
                  margin: const EdgeInsets.symmetric(horizontal: P4, vertical: P2),
                  onTap: _startWithTasks,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MTListTile(
                        leading: const DoneIcon(true, size: P6),
                        middle: H3(loc.onboarding_start_with_tasks_title),
                        trailing: const ChevronIcon(),
                        padding: EdgeInsets.zero,
                        bottomDivider: false,
                      ),
                      const SizedBox(height: P2),
                      BaseText(loc.onboarding_start_with_tasks_text, align: TextAlign.left, maxLines: 3),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
