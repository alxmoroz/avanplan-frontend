// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/images.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/ws_actions.dart';
import '../_base/loader_screen.dart';
import 'template_controller.dart';

Future createFromTemplate(Workspace ws) async {
  final controller = TemplateController(ws.id!);
  controller.reload();
  final template = await showMTDialog<Project?>(_TemplateSelectorDialog(controller));

  if (template != null && await ws.checkBalance(loc.create_from_template_action_title)) {
    controller.setLoaderScreenSaving();
    controller.load(() async {
      final changes = await wsUC.createFromTemplate(template.wsId, template.id!, ws.id!);
      if (changes != null) {
        final p = changes.updated;
        p.filled = true;
        tasksMainController.setTasks([p, ...changes.affected]);
        tasksMainController.refreshUI();

        router.goTaskView(p);
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
        MTListGroupTitle(titleText: Intl.message(group.key), topMargin: gIndex == 0 ? P : null),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: templates.length,
            itemBuilder: (_, tIndex) {
              final template = templates[tIndex];
              return MTListTile(
                leading: MTImage(template.icon ?? 'tmpl_task_list', height: _iconSize, width: _iconSize),
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
              topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.template_selector_title),
              body: ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.templatesGroups.length,
                itemBuilder: _groupBuilder,
              ),
            ),
    );
  }
}
