// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/images.dart';
import '../../components/list_tile.dart';
import '../../components/toolbar.dart';
import '../../navigation/router.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../../usecases/ws_actions.dart';
import '../_base/loader_screen.dart';
import '../app/services.dart';
import 'template_controller.dart';

Future createFromTemplate(Workspace ws) async {
  final controller = TemplateController(ws.id!);
  controller.reload();
  final template = await showMTDialog<Project?>(_TemplateSelectorDialog(controller));

  if (template != null && await ws.checkBalance(loc.create_template_action_title)) {
    controller.setLoaderScreenSaving();
    controller.load(() async {
      final changes = await wsTransferUC.createFromTemplate(template.wsId, template.id!, ws.id!);
      if (changes != null) {
        final p = changes.updated;
        p.filled = true;
        tasksMainController.upsertTasks([p, ...changes.affected]);
        tasksMainController.refreshUI();

        router.goTask(p);
      }
    });
  }
}

class _TemplateSelectorDialog extends StatelessWidget {
  const _TemplateSelectorDialog(this._controller);
  final TemplateController _controller;

  static const _iconSize = 50.0;

  Widget _groupBuilder(BuildContext context, int gIndex) {
    final group = _controller.templatesGroups[gIndex];
    final templates = group.value;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        MTSectionTitle(Intl.message(group.key), topMargin: gIndex == 0 ? P : DEF_VP),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: templates.length,
            itemBuilder: (_, tIndex) {
              final template = templates[tIndex];
              return MTListTile(
                color: b3Color,
                leading: MTImage(template.icon, fallbackName: 'tmpl_task_list', height: _iconSize, width: _iconSize),
                middle: BaseText.medium(template.title, maxLines: 2),
                subtitle: template.description.isNotEmpty ? SmallText(template.description, maxLines: 2) : null,
                dividerIndent: _iconSize + P5,
                bottomDivider: tIndex < templates.length - 1,
                onTap: () => Navigator.of(context).pop(template),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _controller.loading
          ? LoaderScreen(_controller, isDialog: true)
          : MTDialog(
              topBar: MTTopBar(pageTitle: loc.template_selector_title),
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.templatesGroups.length,
                itemBuilder: _groupBuilder,
              ),
            ),
    );
  }
}
