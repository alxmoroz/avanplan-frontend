// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/images.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/route.dart';
import '../../extra/router.dart';
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
  builder: (_, state) => _OnboardingView(OnboardingController(hostProjectIn: state.extra is TaskDescriptor ? state.extra as TaskDescriptor : null)),
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

  Future _goToHostProject() async {
    await _controller.next();
    router.goTaskView(_controller.hostProject!);
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
              if (_controller.isPromoFeaturesStep)
                PromoFeatures(wsMainController.myWS, onLater: _controller.next)
              else if (_controller.isWhereWeGoStep) ...[
                H2(
                  loc.onboarding_where_we_go_step_title,
                  align: TextAlign.center,
                  padding: const EdgeInsets.symmetric(horizontal: P6).copyWith(bottom: P2),
                ),
                MTCardButton(
                  margin: const EdgeInsets.symmetric(horizontal: P4, vertical: P2),
                  onTap: _startWithProject,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(children: [
                        const ProjectsIcon(color: mainColor),
                        const SizedBox(width: P2),
                        Expanded(child: H3(loc.onboarding_start_with_project_title)),
                        const ChevronIcon(),
                      ]),
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
                      Row(children: [
                        const DoneIcon(true, size: P6),
                        const SizedBox(width: P2),
                        Expanded(child: H3(loc.onboarding_start_with_tasks_title)),
                        const ChevronIcon(),
                      ]),
                      const SizedBox(height: P2),
                      BaseText(loc.onboarding_start_with_tasks_text, align: TextAlign.left, maxLines: 3),
                    ],
                  ),
                ),
                if (_controller.hostProject != null) ...[
                  BaseText(loc.onboarding_start_with_host_project_title,
                      align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P4, vertical: P2)),
                  MTCardButton(
                    borderSide: BorderSide(color: greenColor.resolve(context)),
                    margin: const EdgeInsets.symmetric(horizontal: P4),
                    onTap: _goToHostProject,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(children: [
                          const MemberAddIcon(size: P6),
                          const SizedBox(width: P2),
                          Expanded(child: H3(loc.onboarding_start_with_host_project_action_title)),
                          const ChevronIcon(),
                        ]),
                        const SizedBox(height: P2),
                        BaseText(
                          loc.onboarding_start_with_host_project_action_description(_controller.hostProject!.title),
                          align: TextAlign.left,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      );
    });
  }
}
