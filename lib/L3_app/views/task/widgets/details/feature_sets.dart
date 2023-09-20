// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/feature_sets_controller.dart';
import '../../controllers/onboarding_controller.dart';
import '../../controllers/task_controller.dart';
import '../onboarding/header.dart';
import '../onboarding/next_button.dart';

class _FSBody extends StatelessWidget {
  const _FSBody(this._controller, {this.shrinkWrap = true, this.onboarding = false});
  final FeatureSetsController _controller;
  final bool shrinkWrap;
  final bool onboarding;

  Widget _icon(int index) => MTImage(
        [
          ImageName.fs_analytics,
          ImageName.fs_team,
          ImageName.fs_goals,
          ImageName.fs_task_board,
          ImageName.fs_estimates,
        ][index]
            .name,
        width: P8,
        height: P7,
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        topPaddingIndent: 0,
        bottomShadow: onboarding,
        child: ListView(
          shrinkWrap: shrinkWrap,
          children: [
            MTListSection(loc.feature_sets_always_on_label),
            MTCheckBoxTile(
              leading: MTImage(ImageName.fs_task_list.name, width: P8, height: P7),
              title: loc.feature_set_tasklist_title,
              description: loc.feature_set_tasklist_description,
              value: true,
              bottomDivider: false,
            ),
            MTListSection(onboarding ? loc.feature_sets_available_label : loc.feature_sets_label),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _controller.checks.length,
              itemBuilder: (_, index) {
                final fs = refsController.featureSets.elementAt(index);
                return MTCheckBoxTile(
                  leading: _icon(index),
                  title: fs.title,
                  description: fs.description,
                  value: _controller.checks[index],
                  bottomDivider: index < _controller.checks.length - 1,
                  onChanged: !onboarding || _controller.project.loading == true ? null : (bool? value) => _controller.selectFeatureSet(index, value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FSOnboardingArgs {
  FSOnboardingArgs(this._controller, this._onbController);
  final FeatureSetsController _controller;
  final OnboardingController _onbController;
}

class FeatureSetsOnboardingView extends StatelessWidget {
  const FeatureSetsOnboardingView(this._args);
  final FSOnboardingArgs _args;

  static String get routeName => '/feature_sets';
  static String title(FSOnboardingArgs _args) => '${_args._controller.project.viewTitle} - ${loc.feature_sets_title}';

  FeatureSetsController get _controller => _args._controller;
  OnboardingController get _onbController => _args._onbController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: onboardingHeader(context, _onbController),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTAdaptive(child: _FSBody(_controller, shrinkWrap: false, onboarding: true)),
        ),
        bottomBar: OnboardingNextButton(
          _onbController,
          loading: _controller.project.loading,
          margin: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class FeatureSetsDialog extends StatelessWidget {
  const FeatureSetsDialog(FeatureSetsController controller) : _controller = controller;
  final FeatureSetsController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.feature_sets_title),
      body: _FSBody(_controller),
    );
  }
}

Future showFeatureSetsDialog(TaskController controller) async {
  await showMTDialog<void>(FeatureSetsDialog(FeatureSetsController(controller)));
}
