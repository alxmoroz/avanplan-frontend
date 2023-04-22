// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_limit_badge.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_ext_actions.dart';
import '../../import/import_view.dart';
import '../../source/source_type_selector.dart';
import '../../tariff/tariff_select_view.dart';
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
    if (controller.ws!.plProjects) {
      if (controller.mustSelectST && sType == null) {
        controller.selectImportMode();
      } else {
        Navigator.of(context).pop();
        await importTasks(controller.selectedWSId!, sType: sType);
      }
    } else {
      await changeTariff(
        controller.ws!,
        reason: loc.tariff_change_limit_projects_reason_title,
      );
    }
  }

  Widget get wsSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P),
          NormalText(loc.projects_add_select_ws_title),
          ListView.builder(
            shrinkWrap: true,
            itemCount: mainController.workspaces.length,
            itemBuilder: (_, index) {
              final ws = mainController.workspaces[index];
              final canSelect = ws.hpProjectCreate;
              return MTListTile(
                middle: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SmallText('[${ws.code}] ', color: canSelect ? greyColor : lightGreyColor),
                    Expanded(child: MediumText(ws.title, color: canSelect ? darkGreyColor : lightGreyColor)),
                  ],
                ),
                trailing: canSelect ? const ChevronIcon() : const PrivacyIcon(color: lightGreyColor),
                bottomBorder: index < mainController.workspaces.length - 1,
                onTap: canSelect ? () => controller.selectWS(ws.id) : null,
              );
            },
          ),
          const SizedBox(height: P),
        ],
      );

  Widget get modeSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P),
          if (mainController.workspaces.length > 1)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallText('[${controller.ws!.code}] ', color: greyColor),
                MediumText(controller.ws!.title),
              ],
            ),
          const SizedBox(height: P),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              MTLimitBadge(
                showBadge: !controller.ws!.plProjects,
                child: MTButton.outlined(
                  leading: const ImportIcon(),
                  titleText: loc.import_action_title,
                  onTap: () => startImport(null),
                ),
              ),
              const SizedBox(height: P),
              TaskAddButton(TaskViewController(controller.selectedWSId!, null), dismissible: true),
            ],
          ),
          const SizedBox(height: P),
        ],
      );

  Widget get sourceTypeSelector => SourceTypeSelector(startImport);

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => SafeArea(
            bottom: false,
            child: controller.mustSelectWS
                ? wsSelector
                : controller.importMode
                    ? sourceTypeSelector
                    : modeSelector),
      );
}
