// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/source_type.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_adaptive.dart';
import '../../../../components/mt_button.dart';
import '../../../../components/mt_dialog.dart';
import '../../../../components/mt_limit_badge.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/ws_available_actions.dart';
import '../../../../usecases/ws_tariff.dart';
import '../../../import/import_view.dart';
import '../../../source/source_type_selector.dart';
import '../../controllers/create_controller.dart';
import '../task_create_button.dart';
import 'project_create_wizard_controller.dart';
import 'ws_selector.dart';

Future projectCreateWizard() async => await showMTDialog<void>(ProjectCreateWizard());

class ProjectCreateWizard extends StatefulWidget {
  @override
  _ProjectCreateWizardState createState() => _ProjectCreateWizardState();
}

class _ProjectCreateWizardState extends State<ProjectCreateWizard> {
  late final ProjectCreateWizardController controller;

  @override
  void initState() {
    controller = ProjectCreateWizardController();
    super.initState();
  }

  Future startImport(SourceType? sType) async {
    if (controller.ws!.plProjects) {
      if (controller.mustSelectST && sType == null) {
        controller.selectImportMode();
      } else {
        Navigator.of(context).pop();
        await importTasks(controller.selectedWSId!, sType: sType);
      }
    } else {
      Navigator.of(context).pop();
      await controller.ws?.changeTariff(
        reason: loc.tariff_change_limit_projects_reason_title,
      );
    }
  }

  Widget get modeSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P),
          if (mainController.workspaces.length > 1) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallText('[${controller.ws!.code}] '),
                MediumText(controller.ws!.title),
              ],
            ),
          ],
          const SizedBox(height: P),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MTAdaptive.XS(
                MTLimitBadge(
                  showBadge: !controller.ws!.plProjects,
                  child: MTButton.main(
                    leading: const ImportIcon(color: bgL3Color),
                    constrained: false,
                    titleText: loc.import_action_title,
                    onTap: () => startImport(null),
                  ),
                ),
              ),
              const SizedBox(height: P),
              TaskCreateButton(CreateController(controller.ws!, null), dismissible: true),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) => MTDialog(
        body: Observer(
          builder: (_) => controller.mustSelectWS
              ? WSSelector(controller)
              : controller.importMode
                  ? SourceTypeSelector(startImport)
                  : modeSelector,
        ),
      );
}
