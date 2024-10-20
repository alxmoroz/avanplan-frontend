// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_relation.dart';
import '../../controllers/relations_controller.dart';

Future relationsDialog(RelationsController controller) async {
  await showMTDialog(_RelationsDialog(controller));
}

class _RelationsDialog extends StatelessWidget {
  const _RelationsDialog(this._controller);
  final RelationsController _controller;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        showCloseButton: true,
        color: b2Color,
        pageTitle: loc.task_relations_title,
        parentPageTitle: _controller.task.title,
      ),
      body: Observer(
        builder: (_) => MTShadowed(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.sortedRelations.length,
            itemBuilder: (_, index) {
              final r = _controller.sortedRelations[index];
              return MTListTile(
                // leading: MimeTypeIcon(a.type),
                titleText: r.title(_controller.task.id!),
                // subtitle: SmallText(a.bytes.humanBytesStr, maxLines: 1),
                dividerIndent: P6 + P5,
                bottomDivider: index < _controller.sortedRelations.length - 1,
                onTap: () => print('TASK PREVIEW $index'),
              );
            },
          ),
        ),
      ),
    );
  }
}
