// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/checkbox.dart';
import '../../../components/constants.dart';
import '../../../components/dialog.dart';
import '../../../components/toolbar.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_feature_sets.dart';

Future showFeatureSetsDialog(Task project) async => await showMTDialog<void>(FeatureSets(project));

class FeatureSets extends StatelessWidget {
  const FeatureSets(this.project);

  final Task project;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTTopBar(titleText: loc.project_feature_sets_title),
        body: ListView(
          shrinkWrap: true,
          children: [
            for (var fs in refsController.featureSetsMap.values)
              MTCheckBoxTile(
                title: fs.title,
                description: fs.description,
                value: project.hfs(fs.code),
                onChanged: (v) => print(v),
              ),
            const SizedBox(height: P3),
            MTCheckBoxTile(title: loc.feature_set_tasklist_title, description: loc.feature_set_tasklist_description, value: true),
          ],
        ),
        // bottomBar: MTButton.main(titleText: 'SAVE'),
      ),
    );
  }
}
