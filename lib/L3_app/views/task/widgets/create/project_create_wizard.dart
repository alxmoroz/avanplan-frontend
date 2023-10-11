// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
import '../../../source/source_type_selector.dart';
import 'project_create_wizard_controller.dart';
import 'task_create_button.dart';
import 'ws_selector.dart';

Future projectCreateWizard() async => await showMTDialog<void>(ProjectCreateWizard(ProjectCreateWizardController()));

class ProjectCreateWizard extends StatelessWidget {
  const ProjectCreateWizard(this._controller);
  final ProjectCreateWizardController _controller;

  Workspace get ws => _controller.ws!;

  Widget get modeSelector => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: P2),
          if (wsMainController.multiWS) ...[
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
                    onTap: () => _controller.startImport(null),
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
          builder: (_) => _controller.mustSelectWS
              ? WSSelector(_controller)
              : _controller.importMode
                  ? SourceTypeSelector(_controller.startImport)
                  : modeSelector,
        ),
      );
}
