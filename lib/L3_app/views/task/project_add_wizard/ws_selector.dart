// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../usecases/ws_ext_actions.dart';
import 'project_add_wizard_controller.dart';

class WSSelector extends StatelessWidget {
  const WSSelector(this.controller);

  final ProjectAddWizardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: P),
        NormalText(loc.projects_add_select_ws_title),
        const SizedBox(height: P),
        ListView.builder(
          shrinkWrap: true,
          itemCount: mainController.workspaces.length + (controller.noMyWss ? 1 : 0),
          itemBuilder: (_, index) {
            if (index == mainController.workspaces.length) {
              return MTListTile(
                leading: const PlusIcon(),
                middle: MediumText(loc.workspace_my_title, color: mainColor),
                trailing: const ChevronIcon(),
                bottomDivider: false,
                onTap: controller.createMyWS,
                padding: const EdgeInsets.all(P).copyWith(right: P + P_2),
              );
            } else {
              final ws = mainController.workspaces[index];
              final canSelect = ws.hpProjectCreate;
              return MTListTile(
                middle: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SmallText('[${ws.code}] ', color: canSelect ? greyColor : lightGreyColor),
                    Expanded(child: MediumText(ws.title, color: canSelect ? null : lightGreyColor)),
                  ],
                ),
                trailing: canSelect ? const ChevronIcon() : const PrivacyIcon(color: lightGreyColor),
                bottomDivider: index < mainController.workspaces.length - 1,
                onTap: canSelect ? () => controller.selectWS(ws.id) : null,
                padding: const EdgeInsets.all(P).copyWith(right: canSelect ? P + P_2 : P),
              );
            }
          },
        ),
        const SizedBox(height: P),
      ],
    );
  }
}
