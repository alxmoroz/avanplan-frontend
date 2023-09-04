// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/feature_sets_controller.dart';

Future showFeatureSetsDialog(FeatureSetsController controller) async {
  controller.setChecks();
  await showMTDialog<void>(FeatureSets(controller));
}

class FeatureSets extends StatelessWidget {
  const FeatureSets(this.controller);

  final FeatureSetsController controller;
  Task get project => controller.project;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(titleText: loc.project_feature_sets_title),
        body: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.checks.length,
              itemBuilder: (_, index) {
                final fs = refsController.featureSets.elementAt(index);
                return MTCheckBoxTile(
                  title: fs.title,
                  description: fs.description,
                  value: controller.checks[index],
                  onChanged: (bool? value) => controller.selectFeatureSet(index, value),
                );
              },
            ),
            const SizedBox(height: P3),
            MTCheckBoxTile(title: loc.feature_set_tasklist_title, description: loc.feature_set_tasklist_description, value: true),
          ],
        ),
        bottomBar: MTButton.main(
          titleText: controller.taskController.onbController.onboarding ? loc.onboarding_proceed_action_title : loc.save_action_title,
          onTap: controller.setupFeatureSets,
        ),
      ),
    );
  }
}
