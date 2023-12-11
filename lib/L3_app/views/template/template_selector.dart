// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../components/circular_progress.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/images.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'template_controller.dart';

Future<int?> _selectTemplate(TemplateController _controller) async => showMTDialog(TemplateSelector(_controller));

Future importTemplate(int wsId) async {
  final itc = TemplateController(wsId);
  itc.getData();
  final tId = await _selectTemplate(itc);
  if (tId != null) {
    print('importTemplate $tId');
  }
}

class TemplateSelector extends StatelessWidget {
  const TemplateSelector(this._controller);
  final TemplateController _controller;

  Widget _groupBuilder(BuildContext context, int gIndex) {
    final group = _controller.templatesGroups[gIndex];
    final templates = group.value;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        MTListSection(titleText: Intl.message(group.key), topPadding: gIndex == 0 ? P : null),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: templates.length,
            itemBuilder: (_, tIndex) {
              final template = templates[tIndex];
              return MTListTile(
                leading: MTImage(template.icon ?? 'tmpl_task_list', height: P8),
                titleText: template.title,
                subtitle: template.description.isNotEmpty ? SmallText(template.description, maxLines: 2) : null,
                bottomDivider: tIndex < templates.length - 1,
                onTap: () => Navigator.of(context).pop(template.id),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTToolBar(titleText: loc.template_selector_title),
      body: Observer(
        builder: (_) => _controller.loading
            ? const SizedBox(height: P * 20, child: Center(child: MTCircularProgress(color: mainColor)))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.templatesGroups.length,
                itemBuilder: _groupBuilder,
              ),
      ),
    );
  }
}
