// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_dialog.dart';
import '../../../components/mt_limit_badge.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_ext_actions.dart';
import '../../import/import_view.dart';
import '../../source/source_type_selector.dart';
import '../../tariff/tariff_select_view.dart';
import '../task_view_controller.dart';
import '../widgets/task_add_button.dart';
import 'project_add_wizard_controller.dart';
import 'ws_selector.dart';

Future projectAddWizard() async => await showMTDialog<void>(ProjectAddWizard());

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
    if (controller.ws!.plProjects) {
      if (controller.mustSelectST && sType == null) {
        controller.selectImportMode();
      } else {
        Navigator.of(context).pop();
        await importTasks(controller.selectedWSId!, sType: sType);
      }
    } else {
      Navigator.of(context).pop();
      await changeTariff(
        controller.ws!,
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
                SmallText('[${controller.ws!.code}] ', color: greyColor),
                MediumText(controller.ws!.title),
              ],
            ),
          ],
          const SizedBox(height: P),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MTAdaptive.S(
                MTLimitBadge(
                  showBadge: !controller.ws!.plProjects,
                  child: MTButton.main(
                    leading: const ImportIcon(color: lightBackgroundColor),
                    constrained: false,
                    titleText: loc.import_action_title,
                    onTap: () => startImport(null),
                  ),
                ),
              ),
              const SizedBox(height: P),
              TaskAddButton(
                TaskViewController(TaskParams(controller.selectedWSId!)),
                dismissible: true,
              ),
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
