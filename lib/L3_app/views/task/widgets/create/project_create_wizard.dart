// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/source_type.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/limit_badge.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../usecases/ws_tariff.dart';
import '../../../import/import_view.dart';
import '../../../source/source_type_selector.dart';
import 'project_create_wizard_controller.dart';
import 'task_create_button.dart';
import 'ws_selector.dart';

Future projectCreateWizard() async => await showMTDialog<void>(ProjectCreateWizard());

class ProjectCreateWizard extends StatefulWidget {
  @override
  _ProjectCreateWizardState createState() => _ProjectCreateWizardState();
}

class _ProjectCreateWizardState extends State<ProjectCreateWizard> {
  late final ProjectCreateWizardController controller;

  Workspace get ws => controller.ws!;

  @override
  void initState() {
    controller = ProjectCreateWizardController();
    super.initState();
  }

  Future startImport(SourceType? sType) async {
    if (ws.plProjects) {
      if (controller.mustSelectST && sType == null) {
        controller.selectImportMode();
      } else {
        Navigator.of(context).pop();
        await importTasks(controller.selectedWSId!, sType: sType);
      }
    } else {
      Navigator.of(context).pop();
      await ws.changeTariff(
        reason: loc.tariff_change_limit_projects_reason_title,
      );
    }
  }

  Widget get modeSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P2),
          if (mainController.workspaces.length > 1) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseText.f2('[${ws.code}] '),
                BaseText.medium(ws.title),
              ],
            ),
          ],
          const SizedBox(height: P2),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MTAdaptive.XS(
                child: MTLimitBadge(
                  showBadge: !ws.plProjects,
                  child: MTButton.main(
                    leading: const ImportIcon(color: mainBtnTitleColor, size: P4),
                    constrained: false,
                    titleText: loc.import_action_title,
                    onTap: () => startImport(null),
                  ),
                ),
              ),
              const SizedBox(height: P2),
              TaskCreateButton(ws, dismissible: true),
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
