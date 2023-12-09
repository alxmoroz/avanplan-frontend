// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
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

  Widget itemBuilder(BuildContext context, int index) {
    final template = _controller.templates.elementAt(index);
    return MTListTile(
      leading: SmallText('${template.icon ?? 'ICON'}'),
      titleText: template.title,
      subtitle: template.description.isNotEmpty ? SmallText(template.description, maxLines: 2) : null,
      bottomDivider: index < _controller.templates.length - 1,
      onTap: () => Navigator.of(context).pop(template.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTToolBar(titleText: "SELECT_TEMPLATE"),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _controller.templates.length,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
