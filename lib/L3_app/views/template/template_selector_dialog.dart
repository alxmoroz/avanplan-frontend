// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../main.dart';
import '../../components/circular_progress.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/images.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/ws_tariff.dart';
import '../task/controllers/task_controller.dart';
import '../task/task_view.dart';
import 'template_controller.dart';

Future<Project?> _selectTemplate(TemplateController controller) async => showMTDialog<Project?>(_TemplateSelectorDialog(controller));

Future importTemplate(Workspace ws) async {
  final itc = TemplateController(ws.id!);
  itc.getData();
  final template = await _selectTemplate(itc);
  if (template != null && await ws.checkBalance(loc.create_from_template_action_title)) {
    loader.setSaving();
    loader.start();
    final changes = await projectTransferUC.transfer(template.wsId, template.id!, ws.id!);
    final p = changes?.updated;
    if (p != null) {
      changes?.affected.forEach((t) => tasksMainController.setTask(t));
      tasksMainController.setTask(p);
      MTRouter.navigate(TaskRouter, rootKey.currentContext!, args: TaskController(p));
    }
    loader.stop();
  }
}

class _TemplateSelectorDialog extends StatelessWidget {
  const _TemplateSelectorDialog(this._controller);
  final TemplateController _controller;

  static const _iconSize = P8;

  Widget _groupBuilder(BuildContext context, int gIndex) {
    final group = _controller.templatesGroups[gIndex];
    final templates = group.value;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        MTListGroupTitle(titleText: Intl.message(group.key), topPadding: gIndex == 0 ? P : null),
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
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.template_selector_title),
      body: Observer(
        builder: (_) => _controller.loading
            ? const SizedBox(height: P * 30, child: Center(child: MTCircularProgress()))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.templatesGroups.length,
                itemBuilder: _groupBuilder,
              ),
      ),
    );
  }
}
