// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../import/import_view.dart';
import '../../source/source_type_selector.dart';
import '../task_view_controller.dart';
import '../widgets/task_add_button.dart';
import 'project_add_wizard_controller.dart';

Future projectAddWizard() async {
  return await showModalBottomSheet<void>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(ProjectAddWizard()),
  );
}

class ProjectAddWizard extends StatefulWidget {
  @override
  _ProjectAddWizardState createState() => _ProjectAddWizardState();
}

class _ProjectAddWizardState extends State<ProjectAddWizard> {
  late final ProjectAddWizardController controller;

  @override
  void initState() {
    controller = ProjectAddWizardController();
    super.initState();
  }

  Future startImport(String? sType) async {
    if (controller.mustSelectST && sType == null) {
      controller.selectImportMode();
    } else {
      Navigator.of(context).pop();
      await importTasks(controller.selectedWSId!, sType: sType);
    }
  }

  Widget get wsSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: P2),
          H4('WORKSPACES SELECT'),
          SizedBox(height: P2),
        ],
      );

  Widget get modeSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P2),
          MTButton.outlined(
            leading: const ImportIcon(),
            titleText: loc.import_action_title,
            onTap: () => startImport(null),
          ),
          const SizedBox(height: P),
          TaskAddButton(TaskViewController(controller.selectedWSId!, null), dismissible: true),
        ],
      );

  Widget get sourceTypeSelector => SourceTypeSelector(startImport);

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => SafeArea(
            child: controller.mustSelectWS
                ? wsSelector
                : controller.importMode
                    ? sourceTypeSelector
                    : modeSelector),
      );
}
