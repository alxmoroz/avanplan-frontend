// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../navigation/router.dart';
import '../projects/create_project_controller.dart';
import 'onboarding_controller.dart';

class WhereWeGoStep extends StatelessWidget {
  const WhereWeGoStep(this._controller, {super.key});
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
    router.goTask(_controller.hostProject!);
  }

  @override
  Widget build(BuildContext context) {
    return MTAdaptive(
      force: true,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
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
                  if (!kIsWeb) const ChevronIcon(),
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
                  const DoneIcon(true, size: DEF_TAPPABLE_ICON_SIZE),
                  const SizedBox(width: P2),
                  Expanded(child: H3(loc.onboarding_start_with_tasks_title)),
                  if (!kIsWeb) const ChevronIcon(),
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
                    const MemberAddIcon(size: DEF_TAPPABLE_ICON_SIZE),
                    const SizedBox(width: P2),
                    Expanded(child: H3(loc.onboarding_start_with_host_project_action_title)),
                    if (!kIsWeb) const ChevronIcon(),
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
      ),
    );
  }
}
