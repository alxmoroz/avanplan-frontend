// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/images.dart';
import '../../../../components/page.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/feature_sets_controller.dart';
import '../../controllers/task_controller.dart';
import '../onboarding/header.dart';

class _FSBody extends StatelessWidget {
  const _FSBody(this._controller);
  final FeatureSetsController _controller;

  Widget _icon(int index) => MTImage(
      [
        ImageNames.fsAnalytics,
        ImageNames.fsTeam,
        ImageNames.fsGoals,
        ImageNames.fsTaskBoard,
        ImageNames.fsEstimates,
      ][index],
      size: P7);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        bottomShadow: true,
        child: ListView(
          shrinkWrap: true,
          children: [
            MTCheckBoxTile(
                leading: const MTImage(ImageNames.fsTaskList, size: P7),
                title: loc.feature_set_tasklist_title,
                description: loc.feature_set_tasklist_description,
                value: true),
            const SizedBox(height: P3),
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
                  onChanged: (bool? value) => _controller.selectFeatureSet(index, value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureSetsOnboardingPage extends StatelessWidget {
  const FeatureSetsOnboardingPage(this._controller);
  final FeatureSetsController _controller;

  static String get routeName => '/project_feature_sets';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: OnboardingHeader(_controller.taskController.onbController).build(context),
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTAdaptive(child: _FSBody(_controller)),
        ),
        bottomBar: MTButton.main(
          titleText: loc.onboarding_proceed_action_title,
          loading: _controller.project.loading,
          onTap: () => _controller.startOnboarding(context),
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
      topBar: MTTopBar(titleText: loc.project_feature_sets_title),
      body: _FSBody(_controller),
      bottomBar: MTButton.main(
        titleText: loc.save_action_title,
        onTap: _controller.save,
      ),
    );
  }
}

Future showFeatureSetsOnboardingPage(BuildContext context, TaskController controller) async {
  await Navigator.of(context).pushNamed(FeatureSetsOnboardingPage.routeName, arguments: FeatureSetsController(controller));
}

Future showFeatureSetsDialog(TaskController controller) async {
  await showMTDialog<void>(FeatureSetsDialog(FeatureSetsController(controller)));
}
